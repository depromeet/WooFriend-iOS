//
//  SignUpViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/18.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol SignUpPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func backAction()
    func nextAction()
}

final class SignUpViewController: BaseViewController, SignUpPresentable, SignUpViewControllable {
    
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indicatorLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatiorTrailingConstraint: NSLayoutConstraint!
    
    var stepCnt: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var titleName: BehaviorRelay<String> = BehaviorRelay(value: "반려견 정보")
    // TODO: 원래는 false, 테스트는 true
    var isEntered: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    var dogName: String = "멍쿠"
    
    weak var listener: SignUpPresentableListener?
    
    static func instantiate() -> SignUpViewController {
        let vc = Storyboard.SignUpViewController.instantiate(SignUpViewController.self)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
        setCollectionView()
        //        setNavigationBar()
    }
    
    func present(viewController: ViewControllable) {
        viewController.uiviewController.modalPresentationStyle = .fullScreen
        present(viewController.uiviewController, animated: false, completion: nil)
    }
    
}

extension SignUpViewController {
    
    private func bindUI() {
        backButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.listener?.backAction()
            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                // TODO: 필터 같은 오퍼레이터가 있을거 같은데..
                guard let isEntered = self?.isEntered, isEntered.value == true else { return }
                self?.listener?.nextAction()
            })
            .disposed(by: disposeBag)
        
        titleName
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        stepCnt
            .subscribe(onNext: { [weak self] idx in
                guard let self = self else { return }
                if idx == 6 {
                    self.navigationView.isHidden = true
                    self.nextButton.isHidden = true
                }
                
                self.collectionView.scrollToItem(at: IndexPath(row: idx, section: 0), at: .centeredHorizontally, animated: false)
                let current = self.view.bounds.width / 6
                self.indicatiorTrailingConstraint.constant = current * CGFloat((5 - idx))
            })
            .disposed(by: disposeBag)
    }
    
    private func setCollectionView() {
        // MARK: CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        
        collectionView.register(UINib(nibName: "DogNameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DogNameCollectionViewCell")
        collectionView.register(UINib(nibName: "DogBreadCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DogBreadCollectionViewCell")
        collectionView.register(UINib(nibName: "DogConcernCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DogConcernCollectionViewCell")
        collectionView.register(UINib(nibName: "DogPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DogPhotoCollectionViewCell")
        collectionView.register(UINib(nibName: "MyInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyInfoCollectionViewCell")
        collectionView.register(UINib(nibName: "MyIntroductionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyIntroductionCollectionViewCell")
        collectionView.register(UINib(nibName: "WelcomeCell", bundle: nil), forCellWithReuseIdentifier: "WelcomeCell")
        
        
    }
    
}

extension SignUpViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch stepCnt.value {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogNameCollectionViewCell", for: indexPath) as? DogNameCollectionViewCell else { return UICollectionViewCell() }
            
            cell.isChecked.subscribe { b in
                print("setp 0 enalbe == \(b)")
            }
            .disposed(by: disposeBag)

            
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogBreadCollectionViewCell", for: indexPath) as? DogBreadCollectionViewCell else { return UICollectionViewCell() }
            return cell
            
            
        case 2: // 특정 & 관심사
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogConcernCollectionViewCell", for: indexPath) as? DogConcernCollectionViewCell else { return UICollectionViewCell() }
            cell.setData(dogName)
            
            return cell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogPhotoCollectionViewCell", for: indexPath) as? DogPhotoCollectionViewCell else { return UICollectionViewCell() }
            return cell
            
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyInfoCollectionViewCell", for: indexPath) as? MyInfoCollectionViewCell else { return UICollectionViewCell() }
            return cell
            
        case 5:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyIntroductionCollectionViewCell", for: indexPath) as? MyIntroductionCollectionViewCell else { return UICollectionViewCell() }
            return cell
            
        case 6:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCell", for: indexPath) as? WelcomeCell else { return UICollectionViewCell() }
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.frame.size
    }
}

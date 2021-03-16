//
//  DogAttitudeViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs
import RxSwift
import UIKit
import TagListView

fileprivate enum CollectionViewType: Int {
    case character = 1
    case interest = 2
}

protocol DogAttitudePresentableListener: class {
    func nextAction()
    func backAction()
}

final class DogAttitudeViewController: BaseViewController, TagListViewDelegate, DogAttitudePresentable, DogAttitudeViewControllable {
    
    weak var listener: DogAttitudePresentableListener?
    
    @IBOutlet weak var dogCharacterLabel: UILabel!
    @IBOutlet weak var dogInterestLabel: UILabel!
    @IBOutlet weak var characterView: TagListView!
    @IBOutlet weak var interestView: TagListView!
    @IBOutlet weak var indicatiorTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    private let mockCharacter = ["적극적", "소극적", "활발함", "예민함", "겁쟁이", "사교적인", "사나움", "에너자이저", "시크함", "고집쟁이", "젠틀함", "영리함"]
    private let mockInterest = ["노즈워킹", "공놀이", "다이어트", "건강", "간식", "수영", "애견카페", "낮잠", "미용", "훈련", "드라이브", "이성친구"]
    
    var dogAttitude: DogAttitude? = DogAttitude() {
        didSet {
            self.nextButton.backgroundColor = !(self.dogAttitude?.hasNilField() ?? true) ? #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1) : #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        dogCharacterLabel.text = "\(dogName)의 특징"
        //        dogInterestLabel.text = "\(dogName)의 관심사"
        setUI()
        bindUI()
    }
    
    private func setUI() {
        let current = self.view.bounds.width / 6
        self.indicatiorTrailingConstraint.constant = current * CGFloat((5 - 2))
    }
    
    private func bindUI() {
        mockInterest.forEach {
            interestView.addTag("#\($0)").onTap = { [weak self] in
                $0.isSelected.toggle()
            }
            interestView.textFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)!
        }
        
        mockCharacter.forEach {
            characterView.addTag("#\($0)").onTap = { [weak self] in
                $0.isSelected.toggle()
                if $0.isSelected {
                    
                }
            }
            characterView.textFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)!
        }
        
        
        nextButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                guard let self = self else { return }
                
                self.listener?.nextAction()
                
                //TODO: 테스트용
//                if !(self.dogBread?.hasNilField() ?? true) {
//                    self.listener?.nextAction()
//                } else {
//
//                    self.characterView.layer.borderColor = self.dogBread?.bread?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
//                    self.interestView.layer.borderColor = self.dogBread?.bread?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
//                }
            })
            .disposed(by: disposeBag)
        
        backButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                guard let self = self else { return }
                
                self.listener?.backAction()
            })
            .disposed(by: disposeBag)
        
    }
    
}

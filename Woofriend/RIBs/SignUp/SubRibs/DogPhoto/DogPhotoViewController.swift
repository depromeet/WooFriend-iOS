//
//  DogPhotoViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol DogPhotoPresentableListener: class {
    func nextAction()
    func backAction()
}

final class DogPhotoViewController: BaseViewController, DogPhotoPresentable, DogPhotoViewControllable {
    
    weak var listener: DogPhotoPresentableListener?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var indicatiorTrailingConstraint: NSLayoutConstraint!
    
    let imagePickerController = UIImagePickerController()
    var currentIdx = -1
    
    private var photoList: [UIImage?] = [UIImage(named: "photoOne"), UIImage(named: "photoTwo"), UIImage(named: "photoThree"), UIImage(named: "photoAdd")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
    }
    
    private func setUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PhotoAddCell", bundle: nil), forCellWithReuseIdentifier: "PhotoAddCell")
        imagePickerController.delegate = self
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.allowsEditing = true
        //        imagePickerController.videoQuality = .type640x480
        //        imagePickerController.
        let current = self.view.bounds.width / 6
        self.indicatiorTrailingConstraint.constant = current * CGFloat((5 - 3))
    }
    
    private func bindUI() {
        
        nextButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                guard let self = self else { return }
                
                self.listener?.nextAction()
                
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

extension DogPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoAddCell", for: indexPath) as? PhotoAddCell else { return UICollectionViewCell() }
        
        cell.setData(image: photoList[indexPath.row])
        cell.addAction = { [weak self] in
            guard let self = self else { return }
            
            self.currentIdx = indexPath.row
            UIApplication.topViewController()?.present(self.imagePickerController, animated: true, completion: nil)
        }
        // FIXME: 직접 접근 말고 ..
        cell.deleteAction = { [weak self] in
            guard let self = self else { return }
            
            self.currentIdx = indexPath.row
            let idx = IndexPath(row: self.currentIdx, section: 0)
            let targetCell = self.collectionView.cellForItem(at: idx) as? PhotoAddCell
            targetCell?.addImageView.contentMode = .scaleAspectFit
            targetCell?.deleteButton.isHidden = true
            self.collectionView.reloadItems(at: [idx])
        }
        
        return cell
    }
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameWidht = (collectionView.frame.size.width - 16) / 3
        
        return CGSize(width: frameWidht, height: frameWidht * 1.24)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photoList[currentIdx] = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoList[currentIdx] = image
        }
        
        imagePickerController.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            let index = IndexPath(row: self.currentIdx, section: 0)
            
            // FIXME: 직접 접근 말고 ..
            let targetCell = self.collectionView.cellForItem(at: index) as? PhotoAddCell
            targetCell?.addImageView.contentMode = .scaleAspectFill
            targetCell?.deleteButton.isHidden = false
            self.collectionView.reloadItems(at: [index])
        }
    }
    
    // TODO: 나중에 고쳐써야지..
    func resize(image: UIImage, completionHandler: ((UIImage?) -> Void)) {
        let transform = CGAffineTransform(scaleX: 1, y: 1.24)
        let size = image.size.applying(transform)
        UIGraphicsBeginImageContext(size)
        
        image.draw(in: CGRect(origin: .zero, size: size))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        completionHandler(resultImage)
    }
}



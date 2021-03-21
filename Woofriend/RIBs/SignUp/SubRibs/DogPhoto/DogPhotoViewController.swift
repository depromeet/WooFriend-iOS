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
import ZLPhotoBrowser

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
    
    let ps = ZLPhotoPreviewSheet()
    let imagePickerController = UIImagePickerController()
    var currentIdx = -1
    
    private var selectedImages = [UIImage?](repeating: nil, count: 6) {
        didSet {
            self.nextButton.backgroundColor = selectedImages.count > 2 ? #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1) : #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        }
    }
    private var isNext = false
    
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
        let current = self.view.bounds.width / 6
        self.indicatiorTrailingConstraint.constant = current * CGFloat((5 - 3))
    }
    
    private func bindUI() {
        
        nextButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                
                guard let self = self else { return }
                self.isNext = true
                print(self.selectedImages.compactMap({ $0 }).count)
                
                if self.selectedImages.compactMap({ $0 }).count > 2 {
                    self.listener?.nextAction()
                } else {
                    self.collectionView.reloadData()
                }
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
        selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoAddCell", for: indexPath) as? PhotoAddCell else { return UICollectionViewCell() }
                
        cell.setData(image: selectedImages[indexPath.row], isNext: self.isNext)
        // FIXME: 직접 접근 말고 ..
        cell.deleteAction = { [weak self] in
            guard let self = self else { return }
            
            self.currentIdx = indexPath.row
            let idx = IndexPath(row: self.currentIdx, section: 0)
            let targetCell = self.collectionView.cellForItem(at: idx) as? PhotoAddCell
            cell.setData(image: nil, isNext: self.isNext)
            self.selectedImages[indexPath.row] = nil
            targetCell?.deleteButton.isHidden = true
            self.collectionView.reloadItems(at: [idx])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let targetCell = self.collectionView.cellForItem(at: indexPath) as? PhotoAddCell, targetCell.deleteButton.isHidden else { return }
        selectPhotos()
    }
    
    func selectPhotos() {
        let config = ZLPhotoConfiguration.default()
        config.allowSelectImage = true
        config.allowSelectGif = false
        config.allowSelectLivePhoto = false
        config.allowSelectVideo = false
        config.allowSelectOriginal = false
        config.allowMixSelect = false
        let a = selectedImages.compactMap { $0 }
        config.maxSelectCount = 6 - a.count
        
        let photoPicker = ZLPhotoPreviewSheet()
        
        photoPicker.selectImageBlock = { [weak self] (images, assets, _) in
            guard let self = self else { return }
            let images = self.resize(imageList: images)
            
            if self.selectedImages.compactMap({ $0 }).count == 0 {
                for (idx, value) in images.enumerated() {
                    self.selectedImages[idx] = value
                }
            } else {
                // TODO: 추가하는 케이스
            }
            
            self.collectionView.reloadData()
        }
        
        photoPicker.showPhotoLibrary(sender: self)
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
    
    // TODO: 나중에 고쳐써야지..
    func resize(imageList: [UIImage]) -> [UIImage] {
        
        var valueList = [UIImage]()
        for image in imageList {
            let transform = CGAffineTransform(scaleX: 1, y: 1.24)
            let size = image.size.applying(transform)
            UIGraphicsBeginImageContext(size)
            image.draw(in: CGRect(origin: .zero, size: size))
            UIGraphicsEndImageContext()
            valueList.append(image)
        }
        return valueList
    }
}



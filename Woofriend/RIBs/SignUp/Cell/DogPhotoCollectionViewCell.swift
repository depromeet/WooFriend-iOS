//
//  DogPhotoCollectionViewCell.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/21.
//

import UIKit
import Photos

class DogPhotoCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var photoList: [UIImage?] = [UIImage(named: "photoOne"), UIImage(named: "photoTwo"), UIImage(named: "photoThree"), UIImage(named: "photoAdd")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PhotoAddCell", bundle: nil), forCellWithReuseIdentifier: "PhotoAddCell")
        // Initialization code
        //
        //        PHPhotoLibrary.requestAuthorization({ (status) in
        //                                                switch status {
        //                                                case .authorized: break
        //                                                default: break
        //
        //                                                } })
        
    }
    
}

extension DogPhotoCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoAddCell", for: indexPath) as? PhotoAddCell else { return UICollectionViewCell() }
        
        cell.setData(image: photoList[indexPath.row])
        
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
}

//
//  PhotoAddCell.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/23.
//

import UIKit
import RxSwift
import RxGesture

class PhotoAddCell: BaseCollectionViewCell  {

    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    var addAction: (() -> Void)?
    var deleteAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        deleteButton.rx.tapGesture().asSignal()
            .emit(onNext: { [weak self] _ in
                self?.deleteAction?()
            })
            .disposed(by: disposeBag)
        
    }
    
    func setData(image: UIImage?, isNext: Bool) {
        guard let image = image else {
            if isNext {
                deleteButton.isHidden = true
                addImageView.highlightedImage = UIImage(named: "highlightPhoto")
                addImageView.isHighlighted = true
            } else {
                deleteButton.isHidden = true
                addImageView.isHighlighted = false
                addImageView.image = UIImage(named: "needPhoto")
            }
            return
        }
        deleteButton.isHidden = false
        addImageView.image = image
        
    }

}

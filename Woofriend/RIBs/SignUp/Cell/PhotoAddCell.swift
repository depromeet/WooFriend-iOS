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
        
        addImageView.rx.tapGesture().asSignal()
            .emit(onNext: { [weak self] _ in
                self?.addAction?()
            })
            .disposed(by: disposeBag)
        
        deleteButton.rx.tapGesture().asSignal()
            .emit(onNext: { [weak self] _ in
                self?.deleteAction?()
            })
            .disposed(by: disposeBag)
        
    }
    
    func setData(image: UIImage?) {
        guard let image = image else { return }
        addImageView.image = image
        
    }

}

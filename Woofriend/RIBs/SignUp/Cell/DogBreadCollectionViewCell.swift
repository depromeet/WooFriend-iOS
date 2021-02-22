//
//  DogBreadCollectionViewCell.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/21.
//

import UIKit
import RxSwift
import RxGesture


class DogBreadCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var directNameButton: UIButton!
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var dogNameTapView: UIView!
    @IBOutlet weak var neutralCompleteButton: UIButton!
    @IBOutlet weak var neutralDoNotButton: UIButton!
    @IBOutlet weak var inoculationCompleteButton: UIButton!
    @IBOutlet weak var inoculationDoNotButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bindUI()
    }
    
    private func bindUI() {
        
        dogNameTapView.rx.tapGesture().asSignal()
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                
                
            })
            .disposed(by: disposeBag)
        
        
        // MARK: 중성화
        neutralCompleteButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.neutralCompleteButton.isSelected = true
                self?.neutralCompleteButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.neutralCompleteButton.layer.borderColor = UIColor.clear.cgColor
                
                self?.neutralDoNotButton.isSelected = false
                self?.neutralDoNotButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.neutralDoNotButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        neutralDoNotButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.neutralDoNotButton.isSelected = true
                self?.neutralDoNotButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.neutralDoNotButton.layer.borderColor = UIColor.clear.cgColor
                
                self?.neutralCompleteButton.isSelected = false
                self?.neutralCompleteButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.neutralCompleteButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        // MARK: 예방접종
        inoculationCompleteButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.inoculationCompleteButton.isSelected = true
                self?.inoculationCompleteButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.inoculationCompleteButton.layer.borderColor = UIColor.clear.cgColor
                
                self?.inoculationDoNotButton.isSelected = false
                self?.inoculationDoNotButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.inoculationDoNotButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        inoculationDoNotButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.inoculationDoNotButton.isSelected = true
                self?.inoculationDoNotButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.inoculationDoNotButton.layer.borderColor = UIColor.clear.cgColor
                
                self?.inoculationCompleteButton.isSelected = false
                self?.inoculationCompleteButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.inoculationCompleteButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
    }
}

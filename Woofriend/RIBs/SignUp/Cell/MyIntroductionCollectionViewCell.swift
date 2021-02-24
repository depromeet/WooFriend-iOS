//
//  MyIntroductionCollectionViewCell.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/21.
//

import UIKit
import RxSwift
import RxGesture

class MyIntroductionCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var inputTexCnttLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 기본 마진이 있음 -> .zero
        introductionTextView.textContainer.lineFragmentPadding = .zero
        introductionTextView.textContainerInset = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        
        bindUI()
    }
    
    
    private func bindUI() {
        introductionTextView.rx.text.orEmpty
            .scan("", accumulator: { [weak self] (prev, new) -> String in
                guard let self = self else { return "" }
                if new.count == 0 {
                    self.placeHolderLabel.isHidden = false
                    self.introductionTextView.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.introductionTextView.clipsToBounds = true
                } else {
                    self.placeHolderLabel.isHidden = true
                    self.introductionTextView.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1).cgColor
                    self.introductionTextView.clipsToBounds = true
                }
                
                if new.count > 80 {
                    return prev
                } else {
                    self.inputTexCnttLabel.text = "\(new.count)"
                    return new
                }
            })
            .bind(to: introductionTextView.rx.text)
            .disposed(by: disposeBag)
        
        contentView.rx.tapGesture().asSignal()
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.introductionTextView.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
    
}

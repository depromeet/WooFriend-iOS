//
//  DogNameCollectionViewCell.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/21.
//

import UIKit
import RxSwift
import RxGesture

class DogNameCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var otherDogButton: UIButton!
    @IBOutlet weak var dogNameTextField: UITextField!
    @IBOutlet weak var dogMenButton: UIButton!
    @IBOutlet weak var dogWomenButton: UIButton!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var multiDogInfoView: UIView!
    @IBOutlet weak var multiDogInfoCloseButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bindUI()
    }
    
    private func bindUI() {
        multiDogInfoView.isHidden = true
        
        contentView.rx.tapGesture().asSignal()
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.dogNameTextField.resignFirstResponder()
                self.yearTextField.resignFirstResponder()
                self.monthTextField.resignFirstResponder()
                self.dayTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        otherDogButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.multiDogInfoView.isHidden = false
            })
            .disposed(by: disposeBag)
        
        multiDogInfoCloseButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.multiDogInfoView.isHidden = true
            })
            .disposed(by: disposeBag)
        
        
        dogMenButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.dogMenButton.isSelected = true
                self?.dogMenButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.dogMenButton.layer.borderColor = UIColor.clear.cgColor
                
                self?.dogWomenButton.isSelected = false
                self?.dogWomenButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.dogWomenButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        
        dogWomenButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.dogWomenButton.isSelected = true
                self?.dogWomenButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.dogWomenButton.layer.borderColor = UIColor.clear.cgColor
                
                self?.dogMenButton.isSelected = false
                self?.dogMenButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.dogMenButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        // MARK: 텍스트 필드
        
        dogNameTextField.rx.text.orEmpty
            .scan("", accumulator: { (prev, new) -> String in
                new.count > 6 ? prev :  new
            })
            .do { print("dogNameTextField") }
            .bind(to: dogNameTextField.rx.text)
            .disposed(by: disposeBag)
        
        yearTextField.rx.text.orEmpty
            .scan("", accumulator: { (prev, new) -> String in
                new.count > 4 ? prev :  new
            })
            .bind(to: yearTextField.rx.text)
            .disposed(by: disposeBag)
        
        monthTextField.rx.text.orEmpty
            .scan("", accumulator: { (prev, new) -> String in
                new.count > 2 ? prev :  new
            })
            .bind(to: monthTextField.rx.text)
            .disposed(by: disposeBag)
        
        dayTextField.rx.text.orEmpty
            .scan("", accumulator: { (prev, new) -> String in
                new.count > 2 ? prev :  new
            })
            .bind(to: dayTextField.rx.text)
            .disposed(by: disposeBag)
    }
}

//
//  DogNameCollectionViewCell.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/21.
//

import UIKit
import RxGesture

class DogNameCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var otherDogButton: UIButton!
    @IBOutlet weak var dogNameLayerView: UIView!
    @IBOutlet weak var dogNameTextField: UITextField!
    @IBOutlet weak var dogMenButton: UIButton!
    @IBOutlet weak var dogWomenButton: UIButton!
    @IBOutlet weak var dogAgeLayerView: UIView!
    @IBOutlet weak var dogAgeTextField: UITextField!
    @IBOutlet weak var multiDogInfoView: UIView!
    @IBOutlet weak var multiDogInfoCloseButton: UIButton!
    // FIXME: 확정되면 제거하기.
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    /// 체크사항이 3개임
    private var isNextStep = [Bool](repeating: false, count: 3) {
        willSet {
            let cnt = isNextStep.filter { $0 == true}.count
            if cnt == 3 {
                self.isChecked.accept(true)
            } else {
                self.isChecked.accept(false)
            }
        }
    }
    
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
                self.dogAgeTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        otherDogButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.multiDogInfoView.isHidden = false
                self?.isChecked.accept(true)
            })
            .disposed(by: disposeBag)
        
        multiDogInfoCloseButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.multiDogInfoView.isHidden = true
            })
            .disposed(by: disposeBag)
        
        
        dogMenButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.isNextStep[1] = true
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
                self?.isNextStep[1] = true
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
            .scan("", accumulator: { [weak self] (prev, new) -> String in
                guard let self = self else { return "" }
                
                if new.count == 0 {
                    self.isNextStep[0] = false
                    self.dogNameLayerView.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.dogNameLayerView.clipsToBounds = true
                } else {
                    self.isNextStep[0] = true
                    self.dogNameLayerView.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1).cgColor
                    self.dogNameLayerView.clipsToBounds = true
                }
                
                if new.count > 6 {
                    return prev
                } else {
                    return new
                }
            })
            .bind(to: dogNameTextField.rx.text)
            .disposed(by: disposeBag)
        
        dogAgeTextField.rx.text.orEmpty
            .scan("", accumulator: { [weak self] (prev, new) -> String in
                guard let self = self else { return "" }
                
                if new.count == 0 {
                    self.isNextStep[2] = false
                    self.dogAgeLayerView.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.dogAgeLayerView.clipsToBounds = true
                } else {
                    self.isNextStep[2] = true
                    self.dogAgeLayerView.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1).cgColor
                    self.dogAgeLayerView.clipsToBounds = true
                }
                
                if new.count > 2 {
                    return prev
                } else {
                    return new
                }
            })
            .bind(to: dogAgeTextField.rx.text)
            .disposed(by: disposeBag)
        
        // FIXME: 확정되면 제거하기.
        /*
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
        */
    }
}

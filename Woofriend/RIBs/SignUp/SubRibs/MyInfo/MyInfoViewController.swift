//
//  MyInfoViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs
import RxSwift
import UIKit

protocol MyInfoPresentableListener: class {
    func nextAction()
    func backAction()
}

final class MyInfoViewController: BaseViewController, MyInfoPresentable, MyInfoViewControllable {
    
    weak var listener: MyInfoPresentableListener?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var menButton: UIButton!
    @IBOutlet weak var womenButton: UIButton!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var townNameLabel: UILabel!
    @IBOutlet weak var townView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var indicatiorTrailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
    }
    
    private func setUI() {
        let current = self.view.bounds.width / 6
        self.indicatiorTrailingConstraint.constant = current * CGFloat((5 - 4))
    }
    
    private func bindUI() {
        view.rx.tapGesture().asSignal()
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.nameTextField.resignFirstResponder()
                self.yearTextField.resignFirstResponder()
                self.monthTextField.resignFirstResponder()
                self.dayTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        menButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.menButton.isSelected = true
                self?.menButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.menButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                self?.menButton.layer.borderColor = UIColor.clear.cgColor
                self?.menButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 14)!
                
                self?.womenButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!
                self?.womenButton.isSelected = false
                self?.womenButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.womenButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
                self?.womenButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        
        womenButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.womenButton.isSelected = true
                self?.womenButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.womenButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                self?.womenButton.layer.borderColor = UIColor.clear.cgColor
                self?.womenButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 14)!
                
                self?.menButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!
                self?.menButton.isSelected = false
                self?.menButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.menButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
                self?.menButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        // MARK: 텍스트 필드
        
        nameTextField.rx.text.orEmpty
            .scan("", accumulator: { (prev, new) -> String in
                new.count > 6 ? prev :  new
            })
            .bind(to: nameTextField.rx.text)
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
        
        townView.rx.tapGesture().asSignal()
            .emit { _ in
                print(11)
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                guard let self = self else { return }
                
                self.listener?.nextAction()
                
                //TODO: 테스트용
                //                if !(self.dogBread?.hasNilField() ?? true) {
                //                    self.listener?.nextAction()
                //                } else {
                //                    self.dogNameTapView.layer.borderColor = self.dogBread?.bread?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                //                    self.neutralCompleteButton.layer.borderColor = self.dogBread?.isNeutered == nil ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                //                    self.neutralDoNotButton.layer.borderColor = self.dogBread?.isNeutered == nil ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                //                    self.vaccinatedCompleteButton.layer.borderColor = self.dogBread?.isVaccinated == nil ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                //                    self.vaccinatedDoNotButton.layer.borderColor = self.dogBread?.isVaccinated == nil ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :    #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
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

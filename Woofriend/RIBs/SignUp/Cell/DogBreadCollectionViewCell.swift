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
    
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var dogNameTapView: UIView!
    @IBOutlet weak var neutralCompleteButton: UIButton!
    @IBOutlet weak var neutralDoNotButton: UIButton!
    @IBOutlet weak var vaccinatedCompleteButton: UIButton!
    @IBOutlet weak var vaccinatedDoNotButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var breadAction: (() -> Void)?
    var closerDogBread: ((DogBread?) -> Void)?
    private var dogBread: DogBread? = DogBread() {
        willSet {
            self.nextButton.backgroundColor = !(self.dogBread?.hasNilField() ?? true) ? #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1) : #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bindUI()
    }
    
    private func bindUI() {
        
        dogNameTapView.rx.tapGesture().asSignal()
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.breadAction?()
            })
            .disposed(by: disposeBag)
        
        // MARK: 중성화
        neutralCompleteButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.dogBread?.isNeutered = true
                self?.neutralCompleteButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.neutralCompleteButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                self?.neutralCompleteButton.layer.borderColor = UIColor.clear.cgColor
                
                self?.neutralDoNotButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.neutralDoNotButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
                self?.neutralDoNotButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        neutralDoNotButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.dogBread?.isNeutered = false
                self?.neutralDoNotButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.neutralDoNotButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                self?.neutralDoNotButton.layer.borderColor = UIColor.clear.cgColor
                
                self?.neutralCompleteButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.neutralCompleteButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
                self?.neutralCompleteButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        // MARK: 예방접종
        vaccinatedCompleteButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.dogBread?.isVaccinated = true
                self?.vaccinatedCompleteButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.vaccinatedCompleteButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                self?.vaccinatedCompleteButton.layer.borderColor = UIColor.clear.cgColor
                self?.vaccinatedCompleteButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 14)!
                
                self?.vaccinatedDoNotButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!
                self?.vaccinatedDoNotButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.vaccinatedDoNotButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
                self?.vaccinatedDoNotButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        vaccinatedDoNotButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.dogBread?.isVaccinated = false
                self?.vaccinatedDoNotButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.vaccinatedDoNotButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                self?.vaccinatedDoNotButton.layer.borderColor = UIColor.clear.cgColor
                self?.vaccinatedDoNotButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 14)!
                
                self?.vaccinatedCompleteButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!
                self?.vaccinatedCompleteButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.vaccinatedCompleteButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
                self?.vaccinatedCompleteButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                guard let self = self else { return }

                if !(self.dogBread?.hasNilField() ?? true) {
                    self.isChecked.accept(true)
                    self.closerDogBread?(self.dogBread)
                } else {
                    self.isChecked.accept(false)
                    self.dogNameTapView.layer.borderColor = self.dogBread?.bread?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.neutralCompleteButton.layer.borderColor = self.dogBread?.isNeutered == nil ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.neutralDoNotButton.layer.borderColor = self.dogBread?.isNeutered == nil ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.vaccinatedCompleteButton.layer.borderColor = self.dogBread?.isVaccinated == nil ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.vaccinatedDoNotButton.layer.borderColor = self.dogBread?.isVaccinated == nil ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :    #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                }
            })
            .disposed(by: disposeBag)
    }
}

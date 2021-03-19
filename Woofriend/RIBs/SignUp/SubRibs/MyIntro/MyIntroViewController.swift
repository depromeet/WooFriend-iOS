//
//  MyIntroViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol MyIntroPresentableListener: class {
    func nextAction()
    func backAction()
}

final class MyIntroViewController: BaseViewController, MyIntroPresentable, MyIntroViewControllable {
    
    weak var listener: MyIntroPresentableListener?
    
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var inputTexCnttLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var indicatiorTrailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본 마진이 있음 -> .zero
        introductionTextView.textContainer.lineFragmentPadding = .zero
        introductionTextView.textContainerInset = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        
        setUI()
        bindUI()
    }
    
    private func setUI() {
        self.indicatiorTrailingConstraint.constant = 0
    }
    
    private func bindUI() {
        introductionTextView.rx.text.orEmpty
            .scan("", accumulator: { [weak self] (prev, new) -> String in
                guard let self = self else { return "" }
                self.nextButton.backgroundColor = new.count == 0 ? #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1) : #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                if new.count == 0 {
                    self.placeHolderLabel.isHidden = false
                    self.introductionTextView.clipsToBounds = true
                } else {
                    self.placeHolderLabel.isHidden = true
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
        
        view.rx.tapGesture().asSignal()
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.introductionTextView.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        
        introductionTextView.rx.didBeginEditing.asSignal()
            .emit(onNext: { [weak self] in
                self?.introductionTextView.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        introductionTextView.rx.didEndEditing.asSignal()
            .emit(onNext: { [weak self] in
                self?.introductionTextView.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                guard let self = self else { return }
                
                if !self.introductionTextView.text.isEmpty {
                    self.listener?.nextAction()
                } else {
                    self.introductionTextView.layer.borderColor = self.introductionTextView.text.isEmpty ? #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
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


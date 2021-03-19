//
//  DirectBreedViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs
import RxSwift
import UIKit

protocol DirectBreedPresentableListener: class {
    func nextAction()
    func backAction()
}

final class DirectBreedViewController: BaseViewController, DirectBreedPresentable, DirectBreedViewControllable {
    
    weak var listener: DirectBreedPresentableListener?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldLayer: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    var dogBread: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
    }
    
    private func keyboradHideAll() {
        textField.resignFirstResponder()
    }
    
    private func setUI() {
        textField.addDoneButtonOnKeyboard()
    }
    
    private func bindUI() {
        
        view.rx.tapGesture().asSignal()
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.textField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        // MARK: 텍스트 필드
        textField.rx.controlEvent(.editingDidBegin).asSignal()
            .emit(onNext: { [weak self] in
                self?.textFieldLayer.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidEnd).asSignal()
            .emit(onNext: { [weak self] in
                self?.textFieldLayer.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty
                .scan("", accumulator: { [weak self] (prev, new) -> String in
                    
                    if new.count > 10 {
                        return prev
                    } else if new.count == 0 {
                        self?.nextButton.backgroundColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
                        return ""
                    } else {
                        self?.nextButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                        self?.textField?.text = new
                        return new
                    }
                })
                .bind(to: textField.rx.text)
                .disposed(by: disposeBag)
        
        nextButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                guard let self = self else { return }
                
                if !(self.textField?.text?.isEmpty ?? true) {
                    self.dogBread = self.textField?.text ?? ""
                    self.listener?.nextAction()
                } else {
                    self.textFieldLayer.layer.borderColor = self.textField?.text?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
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

//
//  LoggedOutViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol LoggedOutPresentableListener: class {
    func loginAppleID()
    func loginKakaoID()
    func loginNaverID()
}

final class LoggedOutViewController: BaseViewController, LoggedOutPresentable, LoggedOutViewControllable {
    
    // MARK: IBOutlet
    @IBOutlet private weak var appleLoginButton: UIButton!
    @IBOutlet private weak var kakaoLoginButton: UIButton!
    @IBOutlet private weak var naverLoginButton: UIButton!
    
    // MARK: Properties
    
    weak var listener: LoggedOutPresentableListener?
    weak var popUpListener: PopUpViewControllerListener?
    /* Xib
     init() {
     super.init(nibName: nil, bundle: nil)
     }
     
     required init?(coder aDecoder: NSCoder) {
     fatalError("Method is not supported")
     }
     */
    
    // MARK: Lifecycle
    
    static func instantiate() -> LoggedOutViewController {
        let vc = Storyboard.LoggedOutViewController.instantiate(LoggedOutViewController.self)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
    }
    
    // MARK: LoggedOutViewControllable
    
    func present(viewController: ViewControllable) {
        viewController.uiviewController.modalPresentationStyle = .fullScreen
        present(viewController.uiviewController, animated: false, completion: nil)
    }
    
    func dismiss(viewController: ViewControllable) {
        if presentedViewController === viewController.uiviewController {
            dismiss(animated: false, completion: nil)
        }
    }
    
}

// MARK: - Setup

extension LoggedOutViewController: PopUpViewControllerListener {
    func popUpViewClose() {
        print(2131)
    }
    
    private func bindUI() {
        appleLoginButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                let alert = PopUpViewController.instantiate()
                alert.modalPresentationStyle = .overCurrentContext
                self?.present(alert, animated: false, completion: nil)
//                self?.listener?.loginAppleID()
            })
            .disposed(by: disposeBag)
        
        
        kakaoLoginButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.listener?.loginKakaoID()
            })
            .disposed(by: disposeBag)
        
        
        naverLoginButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.listener?.loginNaverID()
            })
            .disposed(by: disposeBag)
    }
}

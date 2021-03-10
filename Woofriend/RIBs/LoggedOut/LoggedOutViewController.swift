//
//  LoggedOutViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import RIBs
import RxSwift
import UIKit
import NaverThirdPartyLogin

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
    weak var naverLogin = NaverThirdPartyLoginConnection.getSharedInstance()
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
        
        naverLogin?.delegate = self
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
//                let alert = PopUpViewController.instantiate()
//                alert.modalPresentationStyle = .overCurrentContext
//                self?.present(alert, animated: false, completion: nil)
                self?.listener?.loginAppleID()
            })
            .disposed(by: disposeBag)
        
        
        kakaoLoginButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                guard let session = KOSession.shared() else { return }
                
                if session.isOpen() {
                    session.close()
                }
                
                session.open { (err) in
                    if err != nil || !session.isOpen() { return }
                    KOSessionTask.userMeTask { (err, user) in
                        guard let user = user else { return }
                        print(user)
                    }
                }
                
                
                
                // self?.listener?.loginKakaoID()
            })
            .disposed(by: disposeBag)
        
        
        naverLoginButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                
                self.naverLogin?.requestThirdPartyLogin()
//                self?.listener?.loginNaverID()
            })
            .disposed(by: disposeBag)
    }
}

extension LoggedOutViewController: NaverThirdPartyLoginConnectionDelegate {
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        
        /*
         네이버 로그인 동의시
         AppDelegate, NaverThirdPartyLoginConnection.getSharedInstance()?.application
         통해서 accessToken, tokenType 토근이 파서 되서 데이터가 들어감
         */
 
        
        print(naverLogin?.accessToken)
        print(naverLogin?.tokenType)
        print()
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        
        // 토큰 유효기간 == 1시간. 
        naverLogin?.isValidAccessTokenExpireTimeNow()
        
        // TODO: 연동해제
        naverLogin?.requestDeleteToken()
        print("oauth20ConnectionDidFinishRequestACTokenWithRefreshToken")
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("oauth20ConnectionDidFinishDeleteToken")
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("====> error:  ", error)
        
    }
    
    
}

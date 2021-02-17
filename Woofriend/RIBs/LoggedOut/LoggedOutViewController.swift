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
        
        setupViews()
    }
}

// MARK: - Setup

extension LoggedOutViewController {
    
    private func setupViews() {
        
        // Signal은 Driver 같음.
        appleLoginButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.listener?.loginAppleID()
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

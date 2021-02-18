//
//  SignUpViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/18.
//

import RIBs
import RxSwift
import UIKit

protocol SignUpPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func backAction()
}

final class SignUpViewController: BaseViewController, SignUpPresentable, SignUpViewControllable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var stepCnt: Int = 0
    
    weak var listener: SignUpPresentableListener?
    
    static func instantiate() -> SignUpViewController {
        let vc = Storyboard.SignUpViewController.instantiate(SignUpViewController.self)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
//        setNavigationBar()
    }
    
    func present(viewController: ViewControllable) {
            viewController.uiviewController.modalPresentationStyle = .fullScreen
            present(viewController.uiviewController, animated: false, completion: nil)
    }
    
}

extension SignUpViewController {
 
    private func bindUI() {
        
        backButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                
                self?.listener?.backAction()
            })
            .disposed(by: disposeBag)
            
    }
    
}

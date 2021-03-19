//
//  BaseViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import RIBs
import UIKit
import RxSwift
import Hero

class BaseViewController: UIViewController, Presentable {
    
    let disposeBag = DisposeBag()
    
    deinit {
        print("[DEINIT] ✨🧹 \(type(of: self)) was deinit.")
    }
    
    func replaceRoot(viewControllable: ViewControllable) {
        replaceRoot(to: viewControllable.uiviewController)
    }
    
    func present(viewController: ViewControllable) {
        viewController.uiviewController.modalPresentationStyle = .fullScreen
        self.present(viewController.uiviewController, animated: false, completion: nil)
    }
    
    
    func push(viewController: ViewControllable) {
        viewController.uiviewController.modalPresentationStyle = .fullScreen
        self.present(viewController.uiviewController, animated: false, completion: nil)
    }
    
    func pageIn(viewController: ViewControllable) {
        viewController.uiviewController.hero.isEnabled = true
        viewController.uiviewController.modalPresentationStyle = .fullScreen
        viewController.uiviewController.hero.modalAnimationType = .push(direction: .left)
        present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    func overView(viewController: ViewControllable) {
        viewController.uiviewController.modalPresentationStyle = .overFullScreen
        self.present(viewController.uiviewController, animated: false, completion: nil)
    }
    
    func dismiss(viewController: ViewControllable) {
        
        if presentedViewController === viewController.uiviewController {
            dismiss(animated: false, completion: nil)
        }
    }
}

extension UIViewController {
    
    func replaceRoot(to nextViewController: UIViewController) {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        
        if window.rootViewController?.presentedViewController != nil {
            fatalError("\(type(of: self)) has presentedViewController")
        }
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: { () -> Void in
                let oldState = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                window.rootViewController = nextViewController
                UIView.setAnimationsEnabled(oldState)
            },
            completion: nil
        )
    }
}


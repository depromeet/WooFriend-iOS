//
//  UIViewController+Extension.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import UIKit

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


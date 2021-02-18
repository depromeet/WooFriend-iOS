//
//  UINavigationContoller+Extension.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/18.
//

import UIKit
import RIBs

// MARK: RIBs
extension UINavigationController: ViewControllable {
    public var uiviewController: UIViewController {
        return self
    }
    
    convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }
}


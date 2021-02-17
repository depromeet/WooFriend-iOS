//
//  BaseViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    deinit {
        print("[DEINIT] ✨🧹 \(type(of: self)) was deinit.")
    }
}

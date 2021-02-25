//
//  BaseCollectionViewCell.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/21.
//

import UIKit
import RxSwift
import RxCocoa

class BaseCollectionViewCell: UICollectionViewCell {
    
    let disposeBag = DisposeBag()
    var isChecked: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    deinit {
        print("[DEINIT] ✨🧹 \(type(of: self)) was deinit.")
    }
}

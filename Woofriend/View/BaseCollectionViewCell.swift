//
//  BaseCollectionViewCell.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/21.
//

import UIKit
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
    
    let disposeBag = DisposeBag()
    
    deinit {
        print("[DEINIT] ✨🧹 \(type(of: self)) was deinit.")
    }
}

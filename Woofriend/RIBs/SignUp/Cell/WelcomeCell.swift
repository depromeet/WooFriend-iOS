//
//  WelcomeCell.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/24.
//

import UIKit
import RxSwift
import RxGesture

class WelcomeCell: BaseCollectionViewCell {
    
    @IBOutlet weak var startButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        startButton.rx.tapGesture().asSignal()
            .emit { _ in
                print(2321312)
            }
            .disposed(by: disposeBag)
        
        
    }
    
}

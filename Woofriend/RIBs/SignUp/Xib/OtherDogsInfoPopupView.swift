//
//  otherDogsInfoPopupView.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/21.
//

import UIKit

class OtherDogsInfoPopupView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nib = UINib(nibName: "OtherDogsInfoPopupView", bundle: Bundle.main)
        
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

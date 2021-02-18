//
//  PopUpView.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/18.
//

import UIKit

class PopUpView: UIView {
    
//    static let instance = PopUpView()
    private var confirmAction: (() -> Void)?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        let className = String(describing: type(of: self))
//        let nib = UINib(nibName: className, bundle: Bundle.main)
//
//
//
////        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
//        xibView.frame = self.bounds
//        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.addSubview(xibView)
//
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    static func showAlert(parent: UIView, confirmAction: (() -> Void)? = nil) {
        guard let xibView = Bundle.main.loadNibNamed("PopUpView", owner: parent)?[0] as? PopUpView else {
//            printd("fail to load view")
            return
        }
        parent.addSubview(xibView)
        
    }
}

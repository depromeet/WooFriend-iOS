//
//  PopUpViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import UIKit

protocol PopUpViewControllerListener: class {
    func popUpViewClose()
}

class PopUpViewController: UIViewController {
    
    // MARK: Lifecycle
    
    static func instantiate() -> PopUpViewController {
        let vc = Storyboard.PopUpViewController.instantiate(PopUpViewController.self)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
}

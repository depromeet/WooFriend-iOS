//
//  Storyboard.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import UIKit

enum Storyboard: String {
    case LoggedOutViewController
    case SignUpViewController
    // SignUp - child
        case SearchDogBreedsViewController
        case DirectBreedViewController
    //
    case PopUpViewController
    
    func instantiate<VC: UIViewController>(_: VC.Type) -> VC {
        guard let vc = UIStoryboard(name: self.rawValue, bundle: nil).instantiateInitialViewController() as? VC else {
            fatalError("Storyboard \(self.rawValue) wasn`t found.")
        }
        return vc
    }
}

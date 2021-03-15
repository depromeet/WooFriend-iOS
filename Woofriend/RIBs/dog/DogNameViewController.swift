//
//  DogNameViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs
import RxSwift
import UIKit

protocol DogNamePresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class DogNameViewController: UIViewController, DogNamePresentable, DogNameViewControllable {

    weak var listener: DogNamePresentableListener?
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .red
    }
}

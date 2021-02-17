//
//  MainViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import RIBs
import RxSwift
import UIKit

protocol MainPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class MainViewController: UIViewController, MainPresentable, MainViewControllable {

    weak var listener: MainPresentableListener?
}

//
//  DirectLocalViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs
import RxSwift
import UIKit

protocol DirectLocalPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class DirectLocalViewController: UIViewController, DirectLocalPresentable, DirectLocalViewControllable {

    weak var listener: DirectLocalPresentableListener?
}

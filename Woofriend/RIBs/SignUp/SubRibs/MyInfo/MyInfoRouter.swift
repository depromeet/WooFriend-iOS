//
//  MyInfoRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs

protocol MyInfoInteractable: Interactable {
    var router: MyInfoRouting? { get set }
    var listener: MyInfoListener? { get set }
}

protocol MyInfoViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class MyInfoRouter: ViewableRouter<MyInfoInteractable, MyInfoViewControllable>, MyInfoRouting {
    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MyInfoInteractable, viewController: MyInfoViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

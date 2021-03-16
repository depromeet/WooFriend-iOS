//
//  MyIntroRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs

protocol MyIntroInteractable: Interactable {
    var router: MyIntroRouting? { get set }
    var listener: MyIntroListener? { get set }
}

protocol MyIntroViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class MyIntroRouter: ViewableRouter<MyIntroInteractable, MyIntroViewControllable>, MyIntroRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MyIntroInteractable, viewController: MyIntroViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

//
//  DogBreadRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol DogBreadInteractable: Interactable {
    var router: DogBreadRouting? { get set }
    var listener: DogBreadListener? { get set }
}

protocol DogBreadViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class DogBreadRouter: ViewableRouter<DogBreadInteractable, DogBreadViewControllable>, DogBreadRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: DogBreadInteractable, viewController: DogBreadViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

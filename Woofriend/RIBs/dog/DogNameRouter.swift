//
//  DogNameRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol DogNameInteractable: Interactable {
    var router: DogNameRouting? { get set }
    var listener: DogNameListener? { get set }
}

protocol DogNameViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class DogNameRouter: ViewableRouter<DogNameInteractable, DogNameViewControllable>, DogNameRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: DogNameInteractable, viewController: DogNameViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

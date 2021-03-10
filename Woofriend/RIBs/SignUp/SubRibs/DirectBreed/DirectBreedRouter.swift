//
//  DirectBreedRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs

protocol DirectBreedInteractable: Interactable {
    var router: DirectBreedRouting? { get set }
    var listener: DirectBreedListener? { get set }
}

protocol DirectBreedViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class DirectBreedRouter: ViewableRouter<DirectBreedInteractable, DirectBreedViewControllable>, DirectBreedRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: DirectBreedInteractable, viewController: DirectBreedViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

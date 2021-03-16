//
//  DogProfileRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol DogProfileInteractable: Interactable {
    var router: DogProfileRouting? { get set }
    var listener: DogProfileListener? { get set }
}

protocol DogProfileViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class DogProfileRouter: ViewableRouter<DogProfileInteractable, DogProfileViewControllable>, DogProfileRouting {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: DogProfileInteractable, viewController: DogProfileViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}

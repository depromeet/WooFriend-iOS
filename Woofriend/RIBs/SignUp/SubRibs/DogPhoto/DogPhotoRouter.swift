//
//  DogPhotoRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs

protocol DogPhotoInteractable: Interactable {
    var router: DogPhotoRouting? { get set }
    var listener: DogPhotoListener? { get set }
}

protocol DogPhotoViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class DogPhotoRouter: ViewableRouter<DogPhotoInteractable, DogPhotoViewControllable>, DogPhotoRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: DogPhotoInteractable, viewController: DogPhotoViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

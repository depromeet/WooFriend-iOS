//
//  DogAttitudeRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol DogAttitudeInteractable: Interactable {
    var router: DogAttitudeRouting? { get set }
    var listener: DogAttitudeListener? { get set }
}

protocol DogAttitudeViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class DogAttitudeRouter: ViewableRouter<DogAttitudeInteractable, DogAttitudeViewControllable>, DogAttitudeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: DogAttitudeInteractable, viewController: DogAttitudeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

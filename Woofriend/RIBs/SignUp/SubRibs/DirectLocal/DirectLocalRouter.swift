//
//  DirectLocalRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs

protocol DirectLocalInteractable: Interactable {
    var router: DirectLocalRouting? { get set }
    var listener: DirectLocalListener? { get set }
}

protocol DirectLocalViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class DirectLocalRouter: ViewableRouter<DirectLocalInteractable, DirectLocalViewControllable>, DirectLocalRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: DirectLocalInteractable, viewController: DirectLocalViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

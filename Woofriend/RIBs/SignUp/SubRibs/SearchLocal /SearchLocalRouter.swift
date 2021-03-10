//
//  SearchLocalRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs

protocol SearchLocalInteractable: Interactable {
    var router: SearchLocalRouting? { get set }
    var listener: SearchLocalListener? { get set }
}

protocol SearchLocalViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchLocalRouter: ViewableRouter<SearchLocalInteractable, SearchLocalViewControllable>, SearchLocalRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchLocalInteractable, viewController: SearchLocalViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

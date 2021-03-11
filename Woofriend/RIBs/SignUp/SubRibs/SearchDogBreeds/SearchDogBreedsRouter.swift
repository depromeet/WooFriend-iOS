//
//  SearchDogBreedsRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs

protocol SearchDogBreedsInteractable: Interactable {
    var router: SearchDogBreedsRouting? { get set }
    var listener: SearchDogBreedsListener? { get set }
}

protocol SearchDogBreedsViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchDogBreedsRouter: ViewableRouter<SearchDogBreedsInteractable, SearchDogBreedsViewControllable>, SearchDogBreedsRouting {   

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchDogBreedsInteractable, viewController: SearchDogBreedsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

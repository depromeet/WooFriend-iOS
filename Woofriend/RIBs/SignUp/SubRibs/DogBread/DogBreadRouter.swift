//
//  DogBreadRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol DogBreadInteractable: Interactable, SearchDogBreedsListener {
    var router: DogBreadRouting? { get set }
    var listener: DogBreadListener? { get set }
}

protocol DogBreadViewControllable: ViewControllable {
    func pageIn(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class DogBreadRouter: ViewableRouter<DogBreadInteractable, DogBreadViewControllable>, DogBreadRouting {

    // MARK: 자식 RIB
    private let searchDogBreedsBuilder: SearchDogBreedsBuilder
    private var searchDogBreedsRouting: SearchDogBreedsRouting?
    
    init(interactor: DogBreadInteractable, viewController: DogBreadViewControllable, searchDogBreedsBuilder: SearchDogBreedsBuilder) {
        
        self.searchDogBreedsBuilder = searchDogBreedsBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    
    func attachToSearchBread() {
        let searchDogBreedsRouting = searchDogBreedsBuilder.build(withListener: interactor)
        self.searchDogBreedsRouting = searchDogBreedsRouting
        attachChild(searchDogBreedsRouting)
        
        viewController.pageIn(viewController: searchDogBreedsRouting.viewControllable)
    }
    
    func detachToSearchBread() {
        guard let searchDogBreedsRouting = searchDogBreedsRouting else { return }
        self.searchDogBreedsRouting = nil
        detachChild(searchDogBreedsRouting)
        
        viewController.dismiss(viewController: searchDogBreedsRouting.viewControllable)
    }
}

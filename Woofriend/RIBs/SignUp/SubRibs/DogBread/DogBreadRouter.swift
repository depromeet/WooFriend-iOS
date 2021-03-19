//
//  DogBreadRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol DogBreadInteractable: Interactable, SearchDogBreedsListener, DirectBreedListener {
    var router: DogBreadRouting? { get set }
    var listener: DogBreadListener? { get set }
}

protocol DogBreadViewControllable: ViewControllable {
    func overView(viewController: ViewControllable)
    func pageIn(viewController: ViewControllable)
    func push(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class DogBreadRouter: ViewableRouter<DogBreadInteractable, DogBreadViewControllable>, DogBreadRouting {
    
    // MARK: 자식 RIB
    private let searchDogBreedsBuilder: SearchDogBreedsBuilder
    private var searchDogBreedsRouting: SearchDogBreedsRouting?
    private let directBreedBuilder: DirectBreedBuilder
    private var directBreedRouting: DirectBreedRouting?
    
    init(interactor: DogBreadInteractable, viewController: DogBreadViewControllable, searchDogBreedsBuilder: SearchDogBreedsBuilder, directBreedBuilder: DirectBreedBuilder ) {
        
        self.searchDogBreedsBuilder = searchDogBreedsBuilder
        self.directBreedBuilder = directBreedBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    
    func attachToSearchBread() {
        let searchDogBreedsRouting = searchDogBreedsBuilder.build(withListener: interactor)
        self.searchDogBreedsRouting = searchDogBreedsRouting
        attachChild(searchDogBreedsRouting)
        
        viewController.overView(viewController: searchDogBreedsRouting.viewControllable)
    }
    
    func detachToSearchBread() {
        if let directBreedRouting = directBreedRouting {
            self.directBreedRouting = nil
            detachChild(directBreedRouting)
            
            viewController.dismiss(viewController: directBreedRouting.viewControllable)
        }
        
        guard let searchDogBreedsRouting = searchDogBreedsRouting else { return }
        self.searchDogBreedsRouting = nil
        detachChild(searchDogBreedsRouting)
        
        viewController.dismiss(viewController: searchDogBreedsRouting.viewControllable)
    }
    
    func attachToDirectBread() {
        guard let searchDogBreedsRouting = searchDogBreedsRouting else { return }
        self.searchDogBreedsRouting = nil
        detachChild(searchDogBreedsRouting)
        
        viewController.dismiss(viewController: searchDogBreedsRouting.viewControllable)
        let directBreedRouting = directBreedBuilder.build(withListener: interactor)
        self.directBreedRouting = directBreedRouting
        attachChild(directBreedRouting)
        
        viewController.push(viewController: directBreedRouting.viewControllable)
    }
    
    func detachToDirectBread() {
        guard let directBreedRouting = directBreedRouting else { return }
        self.directBreedRouting = nil
        detachChild(directBreedRouting)
        
        viewController.dismiss(viewController: directBreedRouting.viewControllable)
        
        attachToSearchBread()
    }
}

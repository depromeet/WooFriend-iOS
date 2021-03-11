//
//  SignUpRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/18.
//

import RIBs

protocol SignUpInteractable: Interactable, SearchDogBreedsListener, SearchLocalListener, DirectBreedListener, DirectLocalListener {
    var router: SignUpRouting? { get set }
    var listener: SignUpListener? { get set }
}

protocol SignUpViewControllable: ViewControllable {
    
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class SignUpRouter: ViewableRouter<SignUpInteractable, SignUpViewControllable>, SignUpRouting {

    // MARK: 자식 RIB
    private let searchDogBreedsBuilder: SearchDogBreedsBuilder
    private var searchDogBreedsRouting: SearchDogBreedsRouting?
    
    private let directBreedBuilder: DirectBreedBuilder
    private var directBreedRouting: DirectBreedRouting?
    
    private let searchLocalBuilder: SearchLocalBuilder
    private var searchLocalRouting: SearchLocalRouting?
    
    private let directLocalBuilder: DirectLocalBuilder
    private var directLocalRouting: DirectLocalRouting?
    
    init(interactor: SignUpInteractable, viewController: SignUpViewControllable, searchDogBreedsBuilder: SearchDogBreedsBuilder, directBreedBuilder: DirectBreedBuilder, searchLocalBuilder: SearchLocalBuilder, directLocalBuilder: DirectLocalBuilder) {
        
        self.searchDogBreedsBuilder = searchDogBreedsBuilder
        self.searchLocalBuilder     = searchLocalBuilder
        self.directBreedBuilder     = directBreedBuilder
        self.directLocalBuilder     = directLocalBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeSearchDogBreeds() {
        
        let searchDogBreedsRouting = searchDogBreedsBuilder.build(withListener: interactor)
        self.searchDogBreedsRouting = searchDogBreedsRouting
        attachChild(searchDogBreedsRouting)
        viewController.present(viewController: searchDogBreedsRouting.viewControllable)
    }
    
    func detachToSearchDogBreeds() {
        guard let searchDogBreedsRouting = searchDogBreedsRouting else { return }
        detachChild(searchDogBreedsRouting)
        viewController.dismiss(viewController: searchDogBreedsRouting.viewControllable)
    }
    
}

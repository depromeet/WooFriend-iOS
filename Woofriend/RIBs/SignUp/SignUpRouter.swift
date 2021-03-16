//
//  SignUpRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/18.
//

import RIBs

protocol SignUpInteractable: Interactable, DogProfileListener, SearchDogBreedsListener, SearchLocalListener, DirectBreedListener, DirectLocalListener {
    var router: SignUpRouting? { get set }
    var listener: SignUpListener? { get set }
}

protocol SignUpViewControllable: ViewControllable {
    
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}


final class SignUpRouter: Router<SignUpInteractable>, SignUpRouting {
    
    // View-less
    private let viewController: SignUpViewControllable
    
    // MARK: 자식 RIB
    private let searchDogBreedsBuilder: SearchDogBreedsBuilder
    private var searchDogBreedsRouting: SearchDogBreedsRouting?
    
    private let dogProfileBuilder: DogProfileBuilder
    private var dogProfileRouting: DogProfileRouting?
    
    private let directBreedBuilder: DirectBreedBuilder
    private var directBreedRouting: DirectBreedRouting?
    
    private let searchLocalBuilder: SearchLocalBuilder
    private var searchLocalRouting: SearchLocalRouting?
    
    private let directLocalBuilder: DirectLocalBuilder
    private var directLocalRouting: DirectLocalRouting?
    
    init(interactor: SignUpInteractable, viewController: SignUpViewControllable, dogProfileBuilder: DogProfileBuilder, searchDogBreedsBuilder: SearchDogBreedsBuilder, directBreedBuilder: DirectBreedBuilder, searchLocalBuilder: SearchLocalBuilder, directLocalBuilder: DirectLocalBuilder) {
        
        self.viewController         = viewController
        self.dogProfileBuilder      = dogProfileBuilder
        self.searchDogBreedsBuilder = searchDogBreedsBuilder
        self.searchLocalBuilder     = searchLocalBuilder
        self.directBreedBuilder     = directBreedBuilder
        self.directLocalBuilder     = directLocalBuilder
        
        super.init(interactor: interactor)
        interactor.router = self
        
    }
    
    override func didLoad() {
        print("didLoad")
        routeChild(step: 0)
    }
    
    
    
    func routeChild(step: Int) {
        
        let dogProfileRouting = dogProfileBuilder.build(withListener: interactor)
        self.dogProfileRouting = dogProfileRouting
        attachChild(dogProfileRouting)
//        let navigationController = UINavigationController(root: dogProfileRouting.viewControllable)
        viewController.present(viewController: dogProfileRouting.viewControllable)
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
    
    // MARK: 바로 부모 해제 하면 leak
    func detachToDogProfile() {
        guard let dogProfileRouting = dogProfileRouting else { return }
        detachChild(dogProfileRouting)
        viewController.dismiss(viewController: dogProfileRouting.viewControllable)
    }
    
    
}

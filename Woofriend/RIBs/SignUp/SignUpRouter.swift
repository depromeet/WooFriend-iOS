//
//  SignUpRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/18.
//

import RIBs

protocol SignUpInteractable: Interactable, DogProfileListener, DogBreadListener, DogAttitudeListener, DogPhotoListener, MyInfoListener, MyIntroListener, SearchLocalListener, DirectBreedListener, DirectLocalListener {
    var router: SignUpRouting? { get set }
    var listener: SignUpListener? { get set }
}

protocol SignUpViewControllable: ViewControllable {
    
    func present(viewController: ViewControllable)
    func pageIn(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}


final class SignUpRouter: Router<SignUpInteractable>, SignUpRouting {
    // View-less
    private let viewController: SignUpViewControllable
    
    // MARK: 자식 RIB
    private let dogProfileBuilder: DogProfileBuilder
    private var dogProfileRouting: DogProfileRouting?
    private let dogBreadBuilder: DogBreadBuilder
    private var dogBreadRouting: DogBreadRouting?
    private let dogAttitudeBuilder: DogAttitudeBuilder
    private var dogAttitudeRouting: DogAttitudeRouting?
    private let dogPhotoBuilder: DogPhotoBuilder
    private var dogPhotoRouting: DogPhotoRouting?
    private let myInfoBuilder: MyInfoBuilder
    private var myInfoRouting: MyInfoRouting?
    private let myIntroBuilder: MyIntroBuilder
    private var myIntroRouting: MyIntroRouting?
    
    private let directBreedBuilder: DirectBreedBuilder
    private var directBreedRouting: DirectBreedRouting?
    
    private let searchLocalBuilder: SearchLocalBuilder
    private var searchLocalRouting: SearchLocalRouting?
    
    private let directLocalBuilder: DirectLocalBuilder
    private var directLocalRouting: DirectLocalRouting?
    
    init(interactor: SignUpInteractable, viewController: SignUpViewControllable,
         dogProfileBuilder: DogProfileBuilder, dogBreadBuilder: DogBreadBuilder,
         dogAttitudeBuilder: DogAttitudeBuilder, dogPhotoBuilder: DogPhotoBuilder,
         myInfoBuilder: MyInfoBuilder, myIntroBuilder: MyIntroBuilder, directBreedBuilder: DirectBreedBuilder,
         searchLocalBuilder: SearchLocalBuilder, directLocalBuilder: DirectLocalBuilder) {
        
        self.viewController         = viewController
        self.dogBreadBuilder        = dogBreadBuilder
        self.dogProfileBuilder      = dogProfileBuilder
        self.dogAttitudeBuilder     = dogAttitudeBuilder
        self.dogPhotoBuilder        = dogPhotoBuilder
        self.myInfoBuilder          = myInfoBuilder
        self.myIntroBuilder         = myIntroBuilder
        self.searchLocalBuilder     = searchLocalBuilder
        self.directBreedBuilder     = directBreedBuilder
        self.directLocalBuilder     = directLocalBuilder
        
        super.init(interactor: interactor)
        interactor.router = self
        
    }
    
    override func didLoad() {
        routeChild(step: 0)
    }
    
    func routeChild(step: Int) {
        let dogProfileRouting = dogProfileBuilder.build(withListener: interactor)
        self.dogProfileRouting = dogProfileRouting
        attachChild(dogProfileRouting)
        
        viewController.present(viewController: dogProfileRouting.viewControllable)
    }
    
    // MARK: 바로 부모 해제 하면 leak
    func detachToDogProfile() {
        guard let dogProfileRouting = dogProfileRouting else { return }
        detachChild(dogProfileRouting)
        viewController.dismiss(viewController: dogProfileRouting.viewControllable)
    }
    
    func attachToDogBread() {
        guard let dogProfileRouting = dogProfileRouting else { return }
        
        detachChild(dogProfileRouting)
        viewController.dismiss(viewController: dogProfileRouting.viewControllable)
        // self.loggedOutRouting = nil
        
        let dogBreadRouting = dogBreadBuilder.build(withListener: interactor)
        self.dogBreadRouting = dogBreadRouting
        attachChild(dogBreadRouting)
        viewController.present(viewController: dogBreadRouting.viewControllable)
    }
    
    func detachToDogBread() {
        guard let dogBreadRouting = dogBreadRouting else { return }
        guard let dogProfileRouting = dogProfileRouting else { return }
        
        detachChild(dogBreadRouting)
        viewController.dismiss(viewController: dogBreadRouting.viewControllable)
        
        attachChild(dogProfileRouting)
        viewController.present(viewController: dogProfileRouting.viewControllable)
    }
    
    func attachToDogAttitude(dogName: String) {
        guard let dogBreadRouting = dogBreadRouting else { return }
        
        detachChild(dogBreadRouting)
        viewController.dismiss(viewController: dogBreadRouting.viewControllable)
        // self.loggedOutRouting = nil
        
        let dogAttitudeRouting = dogAttitudeBuilder.build(withListener: interactor, dogName: dogName)
        self.dogAttitudeRouting = dogAttitudeRouting
        attachChild(dogAttitudeRouting)
        viewController.present(viewController: dogAttitudeRouting.viewControllable)
    }
    
    func detachToDogAttitude() {
        guard let dogBreadRouting = dogBreadRouting else { return }
        guard let dogAttitudeRouting = dogAttitudeRouting else { return }
        
        detachChild(dogAttitudeRouting)
        viewController.dismiss(viewController: dogAttitudeRouting.viewControllable)
        
        attachChild(dogBreadRouting)
        viewController.present(viewController: dogBreadRouting.viewControllable)
    }
    
    func attachToDogPhoto() {
        guard let dogAttitudeRouting = dogAttitudeRouting else { return }
        
        detachChild(dogAttitudeRouting)
        viewController.dismiss(viewController: dogAttitudeRouting.viewControllable)
        // self.loggedOutRouting = nil
        
        let dogPhotoRouting = dogPhotoBuilder.build(withListener: interactor)
        self.dogPhotoRouting = dogPhotoRouting
        attachChild(dogPhotoRouting)
        viewController.present(viewController: dogPhotoRouting.viewControllable)
    }
    
    func detachToDogPhoto() {
        guard let dogAttitudeRouting = dogAttitudeRouting else { return }
        guard let dogPhotoRouting = dogPhotoRouting else { return }
        
        detachChild(dogPhotoRouting)
        viewController.dismiss(viewController: dogPhotoRouting.viewControllable)
        
        attachChild(dogAttitudeRouting)
        viewController.present(viewController: dogAttitudeRouting.viewControllable)
    }
    
    func attachToMyInfo() {
        guard let dogPhotoRouting = dogPhotoRouting else { return }
        
        detachChild(dogPhotoRouting)
        viewController.dismiss(viewController: dogPhotoRouting.viewControllable)
        
        let myInfoRouting = myInfoBuilder.build(withListener: interactor)
        self.myInfoRouting = myInfoRouting
        attachChild(myInfoRouting)
        viewController.present(viewController: myInfoRouting.viewControllable)
    }
    
    func detachToMyInfo() {
        guard let myInfoRouting = myInfoRouting else { return }
        guard let dogPhotoRouting = dogPhotoRouting else { return }
        
        detachChild(myInfoRouting)
        viewController.dismiss(viewController: myInfoRouting.viewControllable)
        
        attachChild(dogPhotoRouting)
        viewController.present(viewController: dogPhotoRouting.viewControllable)
    }
    
    func attachToMyIntro() {
        guard let myInfoRouting = myInfoRouting else { return }
        
        detachChild(myInfoRouting)
        viewController.dismiss(viewController: myInfoRouting.viewControllable)
        
        let myIntroRouting = myIntroBuilder.build(withListener: interactor)
        self.myIntroRouting = myIntroRouting
        attachChild(myInfoRouting)
        viewController.present(viewController: myIntroRouting.viewControllable)
    }
    
    func detachToMyIntro() {
        guard let myInfoRouting = myInfoRouting else { return }
        guard let myIntroRouting = myIntroRouting else { return }
        
        detachChild(myInfoRouting)
        detachChild(myIntroRouting)
        viewController.dismiss(viewController: myIntroRouting.viewControllable)

        attachChild(myInfoRouting)
        viewController.present(viewController: myInfoRouting.viewControllable)
    }
    
    func attachToWelcome() {
        // TODO: 어떤 립에 자식으로 들어가야할까?
    }
    
    func detachToWelcome() {
        // TODO: API 요청해서 MAIN RIB으로
    }
    
}

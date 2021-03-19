//
//  MyInfoRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs

protocol MyInfoInteractable: Interactable, SearchLocalListener, DirectLocalListener {
    var router: MyInfoRouting? { get set }
    var listener: MyInfoListener? { get set }
}

protocol MyInfoViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func push(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class MyInfoRouter: ViewableRouter<MyInfoInteractable, MyInfoViewControllable>, MyInfoRouting {
    
    // MARK: 자식 RIB
    private let searchLocalBuilder: SearchLocalBuilder
    private var searchLocalRouting: SearchLocalRouting?
    private let directLocalBuilder: DirectLocalBuilder
    private var directLocalRouting: DirectLocalRouting?
    
    init(interactor: MyInfoInteractable, viewController: MyInfoViewControllable, searchLocalBuilder: SearchLocalBuilder, directLocalBuilder: DirectLocalBuilder) {
        
        self.searchLocalBuilder = searchLocalBuilder
        self.directLocalBuilder = directLocalBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachToSearchLocal() {
        let searchLocalRouting = searchLocalBuilder.build(withListener: interactor)
        self.searchLocalRouting = searchLocalRouting
        attachChild(searchLocalRouting)
        
        viewController.present(viewController: searchLocalRouting.viewControllable)
    }
    
    func detachToSearchLocal() {
        guard let searchLocalRouting = searchLocalRouting else { return }
        self.searchLocalRouting = nil
        detachChild(searchLocalRouting)
        
        viewController.dismiss(viewController: searchLocalRouting.viewControllable)
    }
    
    func attachToDirectLocal() {
        guard let searchLocalRouting = searchLocalRouting else { return }
        self.searchLocalRouting = nil
        detachChild(searchLocalRouting)
        
        viewController.dismiss(viewController: searchLocalRouting.viewControllable)
        
        let directLocalRouting = directLocalBuilder.build(withListener: interactor)
        self.directLocalRouting = directLocalRouting
        attachChild(directLocalRouting)
        
        viewController.present(viewController: directLocalRouting.viewControllable)
    }
    
    func detachToDirectLocal() {
        guard let directLocalRouting = directLocalRouting else { return }
        self.directLocalRouting = nil
        detachChild(directLocalRouting)
        
        viewController.dismiss(viewController: directLocalRouting.viewControllable)
        
        let searchLocalRouting = searchLocalBuilder.build(withListener: interactor)
        self.searchLocalRouting = searchLocalRouting
        attachChild(searchLocalRouting)
        
        viewController.present(viewController: searchLocalRouting.viewControllable)
    }
    
    func didMyInfo() {
        guard let directLocalRouting = directLocalRouting else { return }
        self.directLocalRouting = nil
        
        detachChild(directLocalRouting)
        viewController.dismiss(viewController: directLocalRouting.viewControllable)
        
        
    }
}

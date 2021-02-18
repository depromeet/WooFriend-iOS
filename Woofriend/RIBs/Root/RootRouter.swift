//
//  RootRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func replaceRoot(viewControllable: ViewControllable)
    func present(viewController: ViewControllable)
}

/**
 자식 RIB을 attach 하거나 detach 함
 */
final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
        
    // MARK: Child RIBs
    
    private let loggedOutBuilder: LoggedOutBuildable
    private var loggedOutRouting: ViewableRouting?
//    private let mainBuilder: MainBuildable
//    private var main: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: RIBs Lifecycle
    override func didLoad() {
        super.didLoad()
        
        // TODO: 이미 로그인 했는지 안했는지 판단하고 지금은 일딴 바로 loggedOut 상태로
        routeToLoggedOut()
    }
    
    func routeToLoggedIn() {
        
    }
    
    func routeToSingUp() {
        
    }
    
    private func routeToLoggedOut() {
        let loggedOutRouting = loggedOutBuilder.build(withListener: interactor)
        self.loggedOutRouting = loggedOutRouting
        attachChild(loggedOutRouting)
        viewController.replaceRoot(viewControllable: loggedOutRouting.viewControllable)
//        let navigationController = UINavigationController(root: loggedOutRouting.viewControllable)
//        navigationController.navigationBar.isHidden = true
//        viewController.present(viewController: navigationController)
    }
}


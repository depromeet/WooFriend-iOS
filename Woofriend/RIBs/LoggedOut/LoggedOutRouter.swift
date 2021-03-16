//
//  LoggedOutRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import RIBs

// 하위 노드(RIB)의
protocol LoggedOutInteractable: Interactable, SignUpListener {
    var router: LoggedOutRouting? { get set }
    var listener: LoggedOutListener? { get set }
}

// Router 정의 -> ViewController에서 구현
protocol LoggedOutViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedOutRouter: ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable> {
    
    // 하위 노드 RIB을 위한 인스턴스
    private let signUpBuilder: SignUpBuildable
    private var signUpRouting: SignUpRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedOutInteractable, viewController: LoggedOutViewControllable, signUpBuilder: SignUpBuildable) {
        self.signUpBuilder = signUpBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}

extension LoggedOutRouter: LoggedOutRouting {
    
    func routeToSignUpRIB() {
        let signUpRouting = signUpBuilder.build(withListener: interactor)
        self.signUpRouting = signUpRouting
        attachChild(signUpRouting)
        
//        viewController.present(viewController: signUpRouting.viewControllable)
    }
    
    func detachToSignUpRIB() {
        guard let signUpRouting = signUpRouting else { return }
        detachChild(signUpRouting)
        
//        viewController.dismiss(viewController: signUpRouting.viewControllable)
    }
    
}

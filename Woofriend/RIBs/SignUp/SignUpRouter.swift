//
//  SignUpRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol SignUpInteractable: Interactable, DogNameListener {
    var router: SignUpRouting? { get set }
    var listener: SignUpListener? { get set }
}

protocol SignUpViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
    
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class SignUpRouter: Router<SignUpInteractable>, SignUpRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    
    // MARK: - Private

    private let viewController: SignUpViewControllable
    private let dogNameBuildable: DogNameBuildable
//    private let dogName: ViewableRouting?
    
    
    init(interactor: SignUpInteractable,
         viewController: SignUpViewControllable,
         dogNameBuilder: DogNameBuildable
    ) {
        self.viewController = viewController
        self.dogNameBuildable = dogNameBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    override func didLoad() {
        
            let x = dogNameBuildable.build(withListener: interactor)
//            self.currentChild = offGame
            attachChild(x)
            viewController.present(viewController: x.viewControllable)
//        let a = dogNameBuildable.build(withListener: interactor)
//        attachChild(a)
//        viewController.present(viewController: a.viewControllable)
        
//        let navigationController = UINavigationController(root: loggedOutRouting.viewControllable)
//        navigationController.navigationBar.isHidden = true
//        viewController.present(viewController: navigationController)
    }
    
    private var currentChild: ViewableRouting?

    private func attachOffGame() {
//        let offGame = offGameBuilder.build(withListener: interactor)
//        self.currentChild = offGame
//        attachChild(offGame)
//        viewController.present(viewController: offGame.viewControllable)
    }
    
    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }

}

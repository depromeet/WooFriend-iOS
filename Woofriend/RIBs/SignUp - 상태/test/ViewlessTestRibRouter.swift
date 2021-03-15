//
//  ViewlessTestRibRouter.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol ViewlessTestRibInteractable: Interactable {
    var router: ViewlessTestRibRouting? { get set }
    var listener: ViewlessTestRibListener? { get set }
}

protocol ViewlessTestRibViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class ViewlessTestRibRouter: Router<ViewlessTestRibInteractable>, ViewlessTestRibRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: ViewlessTestRibInteractable, viewController: ViewlessTestRibViewControllable) {
        self.viewController = viewController
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }

    // MARK: - Private

    private let viewController: ViewlessTestRibViewControllable
}

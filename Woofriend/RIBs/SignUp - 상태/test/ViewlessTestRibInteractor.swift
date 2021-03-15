//
//  ViewlessTestRibInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs
import RxSwift

protocol ViewlessTestRibRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ViewlessTestRibListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ViewlessTestRibInteractor: Interactor, ViewlessTestRibInteractable {

    weak var router: ViewlessTestRibRouting?
    weak var listener: ViewlessTestRibListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
}

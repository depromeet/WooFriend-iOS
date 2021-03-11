//
//  DirectLocalInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs
import RxSwift

protocol DirectLocalRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DirectLocalPresentable: Presentable {
    var listener: DirectLocalPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol DirectLocalListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class DirectLocalInteractor: PresentableInteractor<DirectLocalPresentable>, DirectLocalInteractable, DirectLocalPresentableListener {

    weak var router: DirectLocalRouting?
    weak var listener: DirectLocalListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: DirectLocalPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
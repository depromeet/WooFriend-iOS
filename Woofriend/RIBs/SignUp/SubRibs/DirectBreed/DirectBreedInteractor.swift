//
//  DirectBreedInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs
import RxSwift

protocol DirectBreedRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DirectBreedPresentable: Presentable {
    var listener: DirectBreedPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol DirectBreedListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class DirectBreedInteractor: PresentableInteractor<DirectBreedPresentable>, DirectBreedInteractable, DirectBreedPresentableListener {

    weak var router: DirectBreedRouting?
    weak var listener: DirectBreedListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: DirectBreedPresentable) {
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

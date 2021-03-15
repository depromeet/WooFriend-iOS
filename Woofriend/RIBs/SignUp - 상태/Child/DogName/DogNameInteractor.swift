//
//  DogNameInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs
import RxSwift

protocol DogNameRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DogNamePresentable: Presentable {
    var listener: DogNamePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol DogNameListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class DogNameInteractor: PresentableInteractor<DogNamePresentable>, DogNameInteractable, DogNamePresentableListener {

    weak var router: DogNameRouting?
    weak var listener: DogNameListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: DogNamePresentable) {
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

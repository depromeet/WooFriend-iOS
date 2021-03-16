//
//  DogBreadInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs
import RxSwift

protocol DogBreadRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DogBreadPresentable: Presentable {
    var listener: DogBreadPresentableListener? { get set }
    
    var dogBread: DogBread? { get set }
}

protocol DogBreadListener: class {
    func didDogAttitude()
    func didEndBread()
}

final class DogBreadInteractor: PresentableInteractor<DogBreadPresentable>, DogBreadInteractable, DogBreadPresentableListener {

    weak var router: DogBreadRouting?
    weak var listener: DogBreadListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: DogBreadPresentable) {
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
    
    func nextAction() {
        listener?.didDogAttitude()
    }
    
    func backAction() {
        listener?.didEndBread()
    }
    
}

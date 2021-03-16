//
//  DogProfileInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs
import RxSwift
import RxCocoa

protocol DogProfileRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
//    func detachToDogProfile()
}

protocol DogProfilePresentable: Presentable {
    var listener: DogProfilePresentableListener? { get set }
    var dogProfile: DogProfile? { get set }
}

protocol DogProfileListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func closeSignUp()
    func setDogProfile(_ profile: DogProfile?)
}

final class DogProfileInteractor: PresentableInteractor<DogProfilePresentable>, DogProfileInteractable, DogProfilePresentableListener {
    
    func nextAction() {
        listener?.setDogProfile(presenter.dogProfile)
    }
    
    func backAction() {
        listener?.closeSignUp()
    }

    weak var router: DogProfileRouting?
    weak var listener: DogProfileListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: DogProfilePresentable) {
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

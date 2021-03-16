//
//  DogAttitudeInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs
import RxSwift

protocol DogAttitudeRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DogAttitudePresentable: Presentable {
    var listener: DogAttitudePresentableListener? { get set }
    
    var dogAttitude: DogAttitude? { get set }
}

protocol DogAttitudeListener: class {
    func didDogPhoto()
    func didEndAttitude()
}

final class DogAttitudeInteractor: PresentableInteractor<DogAttitudePresentable>, DogAttitudeInteractable, DogAttitudePresentableListener {
    
    weak var router: DogAttitudeRouting?
    weak var listener: DogAttitudeListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: DogAttitudePresentable) {
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
        listener?.didDogPhoto()
    }
    
    func backAction() {
        listener?.didEndAttitude()
    }
    
}

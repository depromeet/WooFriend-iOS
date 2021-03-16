//
//  DogPhotoInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs
import RxSwift

protocol DogPhotoRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DogPhotoPresentable: Presentable {
    var listener: DogPhotoPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol DogPhotoListener: class {
    func didMyInfo()
    func didEndPhoto()
}

final class DogPhotoInteractor: PresentableInteractor<DogPhotoPresentable>, DogPhotoInteractable, DogPhotoPresentableListener {
    
    weak var router: DogPhotoRouting?
    weak var listener: DogPhotoListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: DogPhotoPresentable) {
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
        listener?.didMyInfo()
    }
    
    func backAction() {
        listener?.didEndPhoto()
    }
    

}

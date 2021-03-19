//
//  SearchLocalInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs
import RxSwift

protocol SearchLocalRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchLocalPresentable: Presentable {
    var listener: SearchLocalPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchLocalListener: class {
    
    func didDirectLocal()
    func didEndSearchLocal(address: String?)
}

final class SearchLocalInteractor: PresentableInteractor<SearchLocalPresentable>, SearchLocalInteractable, SearchLocalPresentableListener {

    weak var router: SearchLocalRouting?
    weak var listener: SearchLocalListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchLocalPresentable) {
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
    
    func currentLocalAction() {
        listener?.didDirectLocal()
    }
    
    func backAction() {
        listener?.didEndSearchLocal(address: "")
    }
    
}

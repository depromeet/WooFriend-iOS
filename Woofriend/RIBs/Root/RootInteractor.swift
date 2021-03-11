//
//  RootInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToLoggedIn()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

/**
 RootViewController의 프로토콜 RootPresentableListener에 정의된 비즈니스 로직을 수행함.
 
 - RootRouting: Router에 처리를 요청함.
 - RootPresentable: Data model를 전달함
 */
final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {
    func didEndWalkthrough() {
        // 회원가입이 안된 상태
    }
    
    func didLogin() {
        // 회원가입이 된 상태
        router?.routeToLoggedIn()
    }

    weak var router: RootRouting?
    weak var listener: RootListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
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

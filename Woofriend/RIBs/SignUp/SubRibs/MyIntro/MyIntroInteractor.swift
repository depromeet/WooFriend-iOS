//
//  MyIntroInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs
import RxSwift

protocol MyIntroRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MyIntroPresentable: Presentable {
    var listener: MyIntroPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MyIntroListener: class {
    func didWelcome()
    func didEndMyIntro()
}

final class MyIntroInteractor: PresentableInteractor<MyIntroPresentable>, MyIntroInteractable, MyIntroPresentableListener {

    weak var router: MyIntroRouting?
    weak var listener: MyIntroListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MyIntroPresentable) {
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
        listener?.didWelcome()
    }
    
    func backAction() {
        listener?.didEndMyIntro()
    }
    
}

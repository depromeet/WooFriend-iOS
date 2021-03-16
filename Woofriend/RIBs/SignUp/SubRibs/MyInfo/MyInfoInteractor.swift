//
//  MyInfoInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs
import RxSwift

protocol MyInfoRouting: ViewableRouting {
    
}

protocol MyInfoPresentable: Presentable {
    var listener: MyInfoPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MyInfoListener: class {
    func didMyIntro()
    func didEndmyInfo()
}

final class MyInfoInteractor: PresentableInteractor<MyInfoPresentable>, MyInfoInteractable, MyInfoPresentableListener {
    
    weak var router: MyInfoRouting?
    weak var listener: MyInfoListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MyInfoPresentable) {
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
        listener?.didMyIntro()
    }
    
    func backAction() {
        listener?.didEndmyInfo()
    }
    
}

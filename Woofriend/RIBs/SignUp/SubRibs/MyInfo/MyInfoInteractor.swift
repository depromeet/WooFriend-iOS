//
//  MyInfoInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs
import RxSwift
import RxCocoa

protocol MyInfoRouting: ViewableRouting {
    func attachToSearchLocal()
    func detachToSearchLocal()
    func attachToDirectLocal()
    func detachToDirectLocal()
    func didMyInfo()
}

protocol MyInfoPresentable: Presentable {
    var listener: MyInfoPresentableListener? { get set }
    var address: BehaviorRelay<String?> { get set }
    var myProfile: MyProfile? { get set }
}

protocol MyInfoListener: class {
    func didMyIntro()
    func didEndmyInfo()
}

final class MyInfoInteractor: PresentableInteractor<MyInfoPresentable>, MyInfoInteractable, MyInfoPresentableListener, SearchLocalListener, DirectLocalListener {
    
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
    
    func nextLocal() {
        router?.attachToSearchLocal()
    }
    
    func didDirectLocal() {
        router?.attachToDirectLocal()
    }
    
    func didEndSearchLocal(address: String?) {
        router?.detachToSearchLocal()
    }
    
    func didBack() {
        router?.detachToDirectLocal()
    }
    
    func didEndDirect(adress: String) {
        router?.didMyInfo()
        presenter.myProfile?.region = adress
        presenter.address.accept(adress)
    }
    
}

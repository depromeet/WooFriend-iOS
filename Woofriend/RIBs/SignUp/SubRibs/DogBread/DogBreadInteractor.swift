//
//  DogBreadInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs
import RxSwift
import RxCocoa

protocol DogBreadRouting: ViewableRouting {
    func attachToSearchBread()
    func detachToSearchBread()
    func attachToDirectBread()
    func detachToDirectBread()
}

protocol DogBreadPresentable: Presentable {
    var listener: DogBreadPresentableListener? { get set }
    
    var dogBread: DogBread? { get set }
    var dogName: BehaviorRelay<String> { get set }
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
    
    func nextSearchBread() {
        router?.attachToSearchBread()
    }
    
    
    func didSeachBread() {
        router?.attachToSearchBread()
    }
    
    func didEndSearchDogBreads(dogBread: String?) {
        presenter.dogName.accept(dogBread ?? "")
        router?.detachToSearchBread()
    }
    
    func didDirectDogBreads() {
        router?.attachToDirectBread()
    }
    
    func didEndDirectBread(dogBread: String?) {
        presenter.dogName.accept(dogBread ?? "")
        router?.detachToSearchBread()
    }
    
    func didBack() {
        router?.detachToDirectBread()
    }
    
}

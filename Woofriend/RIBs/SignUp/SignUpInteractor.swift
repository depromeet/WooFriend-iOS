//
//  SignUpInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/18.
//

import RIBs
import RxSwift
import RxCocoa

protocol SignUpRouting: Routing {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    
    func detachToDogProfile()
    func attachToDogBread()
    func detachToDogBread()
    //
    func routeChild(step: Int)
    func routeSearchDogBreeds()
    func detachToSearchDogBreeds()
}

// 상위 노드가 구현함.
protocol SignUpListener: class {
    func didEndSignUp()
}

final class SignUpInteractor: Interactor, SignUpInteractable {
    
    weak var router: SignUpRouting?
    weak var listener: SignUpListener?
    var dogProfile: DogProfile?
    
    override init() { }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
    }
    
    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func closeSignUp() {
        router?.detachToDogProfile()
        listener?.didEndSignUp()
    }
    
    func didDogBread() {
        router?.attachToDogBread()
    }
    
    func didEndBread() {
        router?.detachToDogBread()
    }
    
    func didDogAttitude() {
        
    }
    
    func setDogProfile(_ profile: DogProfile?) {
        dogProfile = profile
    }
    
    


    func closeSearchDogBreads(dogBread: String?) {
        router?.detachToSearchDogBreeds()
    }

    func closeSearchDogBreads() {
        router?.detachToSearchDogBreeds()
    }

    func didSearchDogBreeds() {
        router?.routeSearchDogBreeds()
    }

}

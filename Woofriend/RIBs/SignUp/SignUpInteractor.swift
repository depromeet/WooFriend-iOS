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
    func attachToDogAttitude(dogName: String)
    func detachToDogAttitude()
    func attachToDogPhoto()
    func detachToDogPhoto()
    func attachToMyInfo()
    func detachToMyInfo()
    func attachToMyIntro()
    func detachToMyIntro()
    func attachToWelcome()
    func detachToWelcome()
    //
    func routeChild(step: Int)
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
//        dogProfile
        router?.attachToDogAttitude(dogName: dogProfile?.name ?? "")
    }
    
    func setDogProfile(_ profile: DogProfile?) {
        dogProfile = profile
    }
    
    func didDogPhoto() {
        router?.attachToDogPhoto()
    }
    
    func didEndAttitude() {
        router?.detachToDogAttitude()
    }
    
    func didMyInfo() {
        router?.attachToMyInfo()
    }
    
    func didMyIntro() {
        router?.attachToMyIntro()
    }
    
    func didEndmyInfo() {
        router?.detachToMyInfo()
    }
    
    func didEndMyIntro() {
        router?.detachToMyIntro()
    }
    
    func didEndPhoto() {
        router?.detachToDogPhoto()
    }
    
    func didWelcome() {
        router?.attachToWelcome()
    }
    
    
    
}

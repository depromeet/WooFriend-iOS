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
    
    func routeChild(step: Int)
    func routeSearchDogBreeds()
    func detachToSearchDogBreeds()
    func detachToDogProfile()
}

// 상위 노드가 구현함.
protocol SignUpListener: class {
    func testttt()
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
        listener?.testttt()
    }
    
    func setDogProfile(_ profile: DogProfile?) {
        dogProfile = profile
        print(dogProfile?.photo)
        print(dogProfile?.name)
        print(dogProfile?.gender)
        print(dogProfile?.age)
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

//
//extension SignUpInteractor: SignUpPresentableListener {
//    
//    func selectedDogBread() {
//        router?.routeSearchDogBreeds()
//    }
//    
//    func backAction() {
//        let nextStepCnt = presenter.stepCnt.value - 1
//        presenter.stepCnt.accept(nextStepCnt)
//        print(presenter.stepCnt.value)
//        switch nextStepCnt {
//        case -1:
//            listener?.closeSignUp()
//        case 0:
//            presenter.titleName.accept("반려견 정보")
//        case 1:
//            presenter.titleName.accept("반려견 정보")
//        case 2:
//            presenter.titleName.accept("반려견 특징&관심사")
//        case 3:
//            presenter.titleName.accept("반려견 사진")
//        case 4:
//            presenter.titleName.accept("견주님 정보")
//        default: break
//        }
//    }
//    
//    func nextAction() {
//        let nextStepCnt = presenter.stepCnt.value + 1
//        guard nextStepCnt < 7 else { return }
//        presenter.stepCnt.accept(nextStepCnt)
//        
//        switch nextStepCnt {
//        case 0:
//            presenter.titleName.accept("반려견 정보")
//        case 1:
//            presenter.titleName.accept("반려견 정보")
//        case 2:
//            presenter.titleName.accept("반려견 특징&관심사")
//        case 3:
//            presenter.titleName.accept("반려견 사진")
//        case 4:
//            presenter.titleName.accept("견주님 정보")
//        case 5:
//            presenter.titleName.accept("한줄 소개")
//        default: break
//        }
//    }
//}

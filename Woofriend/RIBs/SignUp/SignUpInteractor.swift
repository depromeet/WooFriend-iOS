//
//  SignUpInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/18.
//

import RIBs
import RxSwift
import RxCocoa

protocol SignUpRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    
    func routeSearchDogBreeds()
}

protocol SignUpPresentable: Presentable {
    var listener: SignUpPresentableListener? { get set }
    
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    var stepCnt: BehaviorRelay<Int> { get set }
    var titleName: BehaviorRelay<String> { get set }
    var isEntered: BehaviorRelay<[Bool]> { get set }
    var stepState: [Bool] { get set }
    
    // MARK: 반려경 정보
    var dogProfile: BehaviorRelay<DogProfile> { get set }
}

// 상위 노드가 구현함.
protocol SignUpListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func closeSignUp()
}

final class SignUpInteractor: PresentableInteractor<SignUpPresentable>, SignUpInteractable {
    weak var router: SignUpRouting?
    weak var listener: SignUpListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SignUpPresentable) {
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

extension SignUpInteractor: SignUpPresentableListener {
    
    func backAction() {
        let nextStepCnt = presenter.stepCnt.value - 1
        presenter.stepCnt.accept(nextStepCnt)
        print(presenter.stepCnt.value)
        switch nextStepCnt {
        case -1:
            listener?.closeSignUp()
        case 0:
            presenter.titleName.accept("반려견 정보 1")
        case 1:
            presenter.titleName.accept("반려견 정보 2")
        case 2:
            presenter.titleName.accept("반려견 특징&관심사")
        case 3:
            presenter.titleName.accept("반려견 사진")
        case 4:
            presenter.titleName.accept("견주님 정보")
        default: break
        }
    }
    
    func nextAction() {
        let nextStepCnt = presenter.stepCnt.value + 1
        guard nextStepCnt < 7 else { return }
        presenter.stepCnt.accept(nextStepCnt)
        
        switch nextStepCnt {
        case 0:
            presenter.titleName.accept("반려견 정보 1")
        case 1:
            presenter.titleName.accept("반려견 정보 2")
        case 2:
            presenter.titleName.accept("반려견 특징&관심사")
        case 3:
            presenter.titleName.accept("반려견 사진")
        case 4:
            presenter.titleName.accept("견주님 정보")
        case 5:
            presenter.titleName.accept("한줄 소개")
        default: break
        }
    }
}

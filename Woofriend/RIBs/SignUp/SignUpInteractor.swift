//
//  SignUpInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/18.
//

import RIBs
import RxSwift

protocol SignUpRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SignUpPresentable: Presentable {
    var listener: SignUpPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    var stepCnt: Int { get set }
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
        //TODO: step 4단계 체크 0 일때 완전 닫힘
        print(presenter.stepCnt)
        if presenter.stepCnt == 0 {
            // Interactor에서 listener는 상위 노드
            listener?.closeSignUp()
        } else {
            
        }
        
    }
}

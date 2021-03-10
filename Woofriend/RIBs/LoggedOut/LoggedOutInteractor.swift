//
//  LoggedOutInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import RIBs
import RxSwift
import NaverThirdPartyLogin
import KakaoSDKUser

protocol LoggedOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    // TODO: 라우터를 통해 하위 트리를 관리하기 위해 인터랙터가 호출할 수있는 메소드를 호출할 수 있는 메서드를 선언합니다.
    func routeToSignUpRIB()
    func detachToSignUpRIB()
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

// MARK:  Other RIBs - 상위 트리의 Interactor 구현된 메소드 호출
// 상위 노드의 RIB이 다수이고 같은 레벨을 옮겨갈때 사용됨
protocol LoggedOutListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didEndWalkthrough()
    func didLogin()
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {
    
    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?
    weak var naverLogin = NaverThirdPartyLoginConnection.getSharedInstance()
    
    // 여기서 사용되는 컴포넌트?
    private let test: TestResponeType

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: LoggedOutPresentable, test: TestResponeType) {
        self.test = test
        
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        
//        naverLogin?.delegate = self
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - LoggedOutPresentableListener
    func loginAppleID() {
        print("=======  애플로그인")
        
        router?.routeToSignUpRIB()
    }
    
    func getKakaoUserInfo() {
        print("=======  카카오로그인")
        print("=======  회원가입이 안된 상태")
        
        // 하위 노드의 이동
        router?.routeToSignUpRIB()
    }
    
    func loginNaverID() {
        print("=======  네이버로그인")
        print("=======  회원가입이 된 상태")
    }
    
    func closeSignUp() {
        router?.detachToSignUpRIB()
    }
    
    func getNaverUserInfo(auth: String) {
        let a = test.test(auth: auth).asObservable()
        
        
        // TODO: 다음 화면으로 컴포넌트로 넘겨서 처리하는게 좋겠지?
        a.subscribe { [weak self] (res) in
            print("""
                \(res.element?.response.id)
                \(res.element?.response.nickname)
                \(res.element?.response.gender)
                \(res.element?.response.name)
                \(res.element?.response.birthday)
                \(res.element?.response.birthyear)
                """)
            self?.router?.routeToSignUpRIB()
        }

    }

}

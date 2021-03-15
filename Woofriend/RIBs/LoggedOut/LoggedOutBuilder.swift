//
//  LoggedOutBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import RIBs

protocol LoggedOutDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var loggedOutviewController: LoggedInViewControllable { get }
}

final class LoggedOutComponent: Component<LoggedOutDependency> {
    //    var SignUpViewController: SignUpViewControllable
    
    //    var SignUpViewController: SignUpViewControllable
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    
    fileprivate var loggedOutViewController: LoggedOutViewControllable {
        return dependency.loggedOutviewController
    }
    
    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }
}

// MARK: - Builder
protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {
    
    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }
    
    // RIB(하위 노드)를 생성해야함.
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        let componet = LoggedOutComponent(dependency: dependency)
        let interactor = LoggedOutInteractor()
        interactor.listener = listener
        
        let signUpBuilder = SignUpBuilder(dependency: componet.dependency)
        return LoggedOutRouter(interactor: interactor, viewController: componet.loggedOutViewController, signUpBuilder: signUpBuilder)
    }
    
//    func build(withListener listener: LoggedInListener, player1Name: String, player2Name: String) -> LoggedInRouting {
//        let component = LoggedInComponent(dependency: dependency,
//                                          player1Name: player1Name,
//                                          player2Name: player2Name)
//        let interactor = LoggedInInteractor(mutableScoreStream: component.mutableScoreStream)
//        interactor.listener = listener
//
////        let offGameBuilder = OffGameBuilder(dependency: component)
////        let ticTacToeBuilder = TicTacToeBuilder(dependency: component)
//        return LoggedInRouter(interactor: interactor,
//                              viewController: component.loggedInViewController,
//                              offGameBuilder: offGameBuilder,
//                              ticTacToeBuilder: ticTacToeBuilder)
//    }
}

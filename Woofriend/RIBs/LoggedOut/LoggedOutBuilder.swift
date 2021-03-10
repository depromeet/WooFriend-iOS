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
}

final class LoggedOutComponent: Component<LoggedOutDependency>, SignUpDependency {

    // MARK: #네트워크 1. LoggedOut 여기서 생성되는 컴포넌트를 생성
    var networkTest: TestResponeType {
        return shared {
            let repository = TestRepositoy(apiClient: APIClientManager(plugins: []))
            return TestRespone(repository: repository)
        }
        
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
        let component = LoggedOutComponent(dependency: dependency)
        let viewController = LoggedOutViewController.instantiate()
        let interactor = LoggedOutInteractor(presenter: viewController, test: component.networkTest)
        interactor.listener = listener
        
        let signUpBuilder = SignUpBuilder(dependency: component)
        return LoggedOutRouter(interactor: interactor, viewController: viewController, signUpBuilder: signUpBuilder)
    }
}

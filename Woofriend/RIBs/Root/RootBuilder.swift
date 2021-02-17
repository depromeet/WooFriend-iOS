//
//  RootBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

/**
 부모 RIB Builder가 Component를 통해 자식 RIB Builder로 의존성을 주입함.
 */
final class RootComponent: Component<RootDependency> {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    let rootViewController: RootViewController

    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    /// The root `Router` of an application.
    func build() -> LaunchRouting
}

/**
 Root RIB의 모든 구성요소를 생성하고 DI를 정의함.
 - RootRouter, RootInteractor, RootViewController, RootComponent 생성함.
 */
final class RootBuilder: Builder<RootDependency>, RootBuildable {
    
    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
    
    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let component = RootComponent(dependency: dependency, rootViewController: viewController)
        let interactor = RootInteractor(presenter: viewController)
        
        // Child RIBs -> Logged out, Main
        
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          loggedOutBuilder: loggedOutBuilder)
    }
}

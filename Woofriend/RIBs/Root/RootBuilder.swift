//
//  RootBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import RIBs

// 외부 또는 상위 RIB에서 의존성 주입을 받야하는 것들을 정의함.
protocol RootDependency: Dependency {}

// RootDependency 프로토콜을 구현함.
final class RootComponent: Component<RootDependency> {}

// 생성할 RIB을 프로토콜로 정의함.
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
        let component = RootComponent(dependency: dependency)
        let interactor = RootInteractor(presenter: viewController)
        
        //TODO: Child RIBs -> Logged out, Main
        
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          loggedOutBuilder: loggedOutBuilder)
    }
}

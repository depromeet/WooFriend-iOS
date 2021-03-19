//
//  MyInfoBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs

protocol MyInfoDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MyInfoComponent: Component<MyInfoDependency>, SearchLocalDependency, DirectLocalDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MyInfoBuildable: Buildable {
    func build(withListener listener: MyInfoListener) -> MyInfoRouting
}

final class MyInfoBuilder: Builder<MyInfoDependency>, MyInfoBuildable {

    override init(dependency: MyInfoDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MyInfoListener) -> MyInfoRouting {
        let component = MyInfoComponent(dependency: dependency)
        let viewController = MyInfoViewController()
        let interactor = MyInfoInteractor(presenter: viewController)
        interactor.listener = listener
        
        let searchLocalBuilder  = SearchLocalBuilder(dependency: component)
        let directLocalBuilder = DirectLocalBuilder(dependency: component)
        
        return MyInfoRouter(interactor: interactor, viewController: viewController, searchLocalBuilder: searchLocalBuilder, directLocalBuilder: directLocalBuilder)
    }
}

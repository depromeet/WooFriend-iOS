//
//  DirectLocalBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs

protocol DirectLocalDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class DirectLocalComponent: Component<DirectLocalDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DirectLocalBuildable: Buildable {
    func build(withListener listener: DirectLocalListener) -> DirectLocalRouting
}

final class DirectLocalBuilder: Builder<DirectLocalDependency>, DirectLocalBuildable {

    override init(dependency: DirectLocalDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DirectLocalListener) -> DirectLocalRouting {
        let component = DirectLocalComponent(dependency: dependency)
        let viewController = DirectLocalViewController()
        let interactor = DirectLocalInteractor(presenter: viewController)
        interactor.listener = listener
        return DirectLocalRouter(interactor: interactor, viewController: viewController)
    }
}

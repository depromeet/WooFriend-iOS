//
//  DirectBreedBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs

protocol DirectBreedDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class DirectBreedComponent: Component<DirectBreedDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DirectBreedBuildable: Buildable {
    func build(withListener listener: DirectBreedListener) -> DirectBreedRouting
}

final class DirectBreedBuilder: Builder<DirectBreedDependency>, DirectBreedBuildable {

    override init(dependency: DirectBreedDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DirectBreedListener) -> DirectBreedRouting {
        let component = DirectBreedComponent(dependency: dependency)
        let viewController = DirectBreedViewController()
        let interactor = DirectBreedInteractor(presenter: viewController)
        interactor.listener = listener
        return DirectBreedRouter(interactor: interactor, viewController: viewController)
    }
}

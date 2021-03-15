//
//  DogNameBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol DogNameDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class DogNameComponent: Component<DogNameDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DogNameBuildable: Buildable {
    func build(withListener listener: DogNameListener) -> DogNameRouting
}

final class DogNameBuilder: Builder<DogNameDependency>, DogNameBuildable {

    override init(dependency: DogNameDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DogNameListener) -> DogNameRouting {
        let component = DogNameComponent(dependency: dependency)
        let viewController = DogNameViewController()
        let interactor = DogNameInteractor(presenter: viewController)
        interactor.listener = listener
        return DogNameRouter(interactor: interactor, viewController: viewController)
    }
}

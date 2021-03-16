//
//  DogProfileBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol DogProfileDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class DogProfileComponent: Component<DogProfileDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DogProfileBuildable: Buildable {
    func build(withListener listener: DogProfileListener) -> DogProfileRouting
}

final class DogProfileBuilder: Builder<DogProfileDependency>, DogProfileBuildable {

    override init(dependency: DogProfileDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DogProfileListener) -> DogProfileRouting {
        let component = DogProfileComponent(dependency: dependency)
        let viewController = DogProfileViewController()
        let interactor = DogProfileInteractor(presenter: viewController)
        interactor.listener = listener
        return DogProfileRouter(interactor: interactor, viewController: viewController)
    }
}

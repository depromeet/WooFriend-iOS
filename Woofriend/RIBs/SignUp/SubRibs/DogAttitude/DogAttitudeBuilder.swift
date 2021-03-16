//
//  DogAttitudeBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol DogAttitudeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class DogAttitudeComponent: Component<DogAttitudeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DogAttitudeBuildable: Buildable {
    func build(withListener listener: DogAttitudeListener, dogName: String) -> DogAttitudeRouting
}

final class DogAttitudeBuilder: Builder<DogAttitudeDependency>, DogAttitudeBuildable {

    override init(dependency: DogAttitudeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DogAttitudeListener, dogName: String) -> DogAttitudeRouting {
        let component = DogAttitudeComponent(dependency: dependency)
        let viewController = DogAttitudeViewController()
        let interactor = DogAttitudeInteractor(presenter: viewController)
        interactor.listener = listener
        return DogAttitudeRouter(interactor: interactor, viewController: viewController)
    }
}

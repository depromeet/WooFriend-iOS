//
//  DogPhotoBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs

protocol DogPhotoDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class DogPhotoComponent: Component<DogPhotoDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DogPhotoBuildable: Buildable {
    func build(withListener listener: DogPhotoListener) -> DogPhotoRouting
}

final class DogPhotoBuilder: Builder<DogPhotoDependency>, DogPhotoBuildable {

    override init(dependency: DogPhotoDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DogPhotoListener) -> DogPhotoRouting {
        let component = DogPhotoComponent(dependency: dependency)
        let viewController = DogPhotoViewController()
        let interactor = DogPhotoInteractor(presenter: viewController)
        interactor.listener = listener
        return DogPhotoRouter(interactor: interactor, viewController: viewController)
    }
}

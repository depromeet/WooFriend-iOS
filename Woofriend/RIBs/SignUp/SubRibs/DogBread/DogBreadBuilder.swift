//
//  DogBreadBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol DogBreadDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class DogBreadComponent: Component<DogBreadDependency>, SearchDogBreedsDependency, DirectBreedDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DogBreadBuildable: Buildable {
    func build(withListener listener: DogBreadListener) -> DogBreadRouting
}

final class DogBreadBuilder: Builder<DogBreadDependency>, DogBreadBuildable {

    override init(dependency: DogBreadDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DogBreadListener) -> DogBreadRouting {
        let component = DogBreadComponent(dependency: dependency)
        let viewController = DogBreadViewController()
        let interactor = DogBreadInteractor(presenter: viewController)
        interactor.listener = listener
        
        
        let searchDogBreedsBuilder  = SearchDogBreedsBuilder(dependency: component)
        let directBreedBuilder = DirectBreedBuilder(dependency: component)
        
        return DogBreadRouter(interactor: interactor, viewController: viewController, searchDogBreedsBuilder: searchDogBreedsBuilder, directBreedBuilder: directBreedBuilder)
    }
}

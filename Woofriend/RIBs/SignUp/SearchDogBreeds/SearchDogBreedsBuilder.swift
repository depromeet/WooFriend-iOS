//
//  SearchDogBreedsBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs

protocol SearchDogBreedsDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchDogBreedsComponent: Component<SearchDogBreedsDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchDogBreedsBuildable: Buildable {
    func build(withListener listener: SearchDogBreedsListener) -> SearchDogBreedsRouting
}

final class SearchDogBreedsBuilder: Builder<SearchDogBreedsDependency>, SearchDogBreedsBuildable {

    override init(dependency: SearchDogBreedsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchDogBreedsListener) -> SearchDogBreedsRouting {
        let component = SearchDogBreedsComponent(dependency: dependency)
        let viewController = SearchDogBreedsViewController()
        let interactor = SearchDogBreedsInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchDogBreedsRouter(interactor: interactor, viewController: viewController)
    }
}

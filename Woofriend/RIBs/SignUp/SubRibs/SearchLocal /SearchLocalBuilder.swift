//
//  SearchLocalBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs

protocol SearchLocalDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchLocalComponent: Component<SearchLocalDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchLocalBuildable: Buildable {
    func build(withListener listener: SearchLocalListener) -> SearchLocalRouting
}

final class SearchLocalBuilder: Builder<SearchLocalDependency>, SearchLocalBuildable {

    override init(dependency: SearchLocalDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchLocalListener) -> SearchLocalRouting {
        let component = SearchLocalComponent(dependency: dependency)
        let viewController = SearchLocalViewController()
        let interactor = SearchLocalInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchLocalRouter(interactor: interactor, viewController: viewController)
    }
}

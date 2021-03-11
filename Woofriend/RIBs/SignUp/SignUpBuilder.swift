//
//  SignUpBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/18.
//

import RIBs

protocol SignUpDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SignUpComponent: Component<SignUpDependency>, SearchLocalDependency, SearchDogBreedsDependency, DirectBreedDependency, DirectLocalDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SignUpBuildable: Buildable {
    func build(withListener listener: SignUpListener) -> SignUpRouting
}

final class SignUpBuilder: Builder<SignUpDependency>, SignUpBuildable {

    override init(dependency: SignUpDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SignUpListener) -> SignUpRouting {
        let component = SignUpComponent(dependency: dependency)
        let viewController = SignUpViewController.instantiate()
        let interactor = SignUpInteractor(presenter: viewController)
        interactor.listener = listener
        
        // 자식뷰 빌더
        let searchLocalBuilder = SearchLocalBuilder(dependency: component)
        let searchDogBreedsBuilder = SearchDogBreedsBuilder(dependency: component)
        let directLocalBuilder = DirectLocalBuilder(dependency: component)
        let directBreedBuilder = DirectBreedBuilder(dependency: component)
        return SignUpRouter(interactor: interactor,
                            viewController: viewController,
                            searchDogBreedsBuilder: searchDogBreedsBuilder,
                            directBreedBuilder: directBreedBuilder,
                            searchLocalBuilder: searchLocalBuilder,
                            directLocalBuilder: directLocalBuilder
        )
    }
}

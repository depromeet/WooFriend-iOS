//
//  SignUpBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol SignUpDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var signUpViewController: SignUpViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class SignUpComponent: Component<SignUpDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var SignUpViewController: SignUpViewControllable {
        return dependency.signUpViewController
    }

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
        let interactor = SignUpInteractor()
        interactor.listener = listener
        
        // 자식 뷰
        let dogNameBuilder = DogNameBuilder(dependency: component)
        
        return SignUpRouter(
            interactor: interactor,
            viewController: component.SignUpViewController,
            dogNameBuilder: dogNameBuilder
        )
    }
}

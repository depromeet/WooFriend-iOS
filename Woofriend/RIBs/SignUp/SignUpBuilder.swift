//
//  SignUpBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/18.
//

import RIBs

protocol SignUpDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var signUpViewController: SignUpViewControllable { get }
    
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SignUpComponent: Component<SignUpDependency>, DogProfileDependency, DogBreadDependency, DogAttitudeDependency, DogPhotoDependency, MyInfoDependency, MyIntroDependency{
    
    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var signUpViewController: SignUpViewControllable {
        return dependency.signUpViewController
    }
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
        
        // 자식뷰 빌더
        let dogProfileBuilder       = DogProfileBuilder(dependency: component)
        let dogBreadBuilder         = DogBreadBuilder(dependency: component)
        let dogAttitudeBuilder      = DogAttitudeBuilder(dependency: component)
        let dogPhotoBuilder         = DogPhotoBuilder(dependency: component)
        let myInfoBuilder           = MyInfoBuilder(dependency: component)
        let myIntroBuilder          = MyIntroBuilder(dependency: component)
        
        return SignUpRouter(
            interactor: interactor,
            viewController: component.signUpViewController,
            dogProfileBuilder: dogProfileBuilder,
            dogBreadBuilder: dogBreadBuilder,
            dogAttitudeBuilder: dogAttitudeBuilder,
            dogPhotoBuilder: dogPhotoBuilder,
            myInfoBuilder: myInfoBuilder,
            myIntroBuilder: myIntroBuilder
        )
    }
}

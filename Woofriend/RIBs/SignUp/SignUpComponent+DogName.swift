//
//  SignUpComponent+DogName.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

/// The dependencies needed from the parent scope of SignUp to provide for the DogName scope.
// TODO: Update SignUpDependency protocol to inherit this protocol.
protocol SignUpDependencyDogName: Dependency {
    // TODO: Declare dependencies needed from the parent scope of SignUp to provide dependencies
    // for the DogName scope.
}

extension SignUpComponent: DogNameDependency {

    // TODO: Implement properties to provide for DogName scope.
}

//
//  LoggedOutComponent+SignUp.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

/// The dependencies needed from the parent scope of LoggedOut to provide for the SignUp scope.
// TODO: Update LoggedOutDependency protocol to inherit this protocol.
protocol LoggedOutDependencySignUp: Dependency {
    // TODO: Declare dependencies needed from the parent scope of LoggedOut to provide dependencies
    // for the SignUp scope.
}

extension LoggedOutComponent: SignUpDependency {
    // TODO: Implement properties to provide for SignUp scope.
    
    var signUpViewController: SignUpViewControllable {
        return logge
    }
}

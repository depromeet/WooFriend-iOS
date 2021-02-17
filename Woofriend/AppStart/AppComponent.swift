//
//  AppComponent.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/17.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
}

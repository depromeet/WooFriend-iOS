//
//  MyIntroBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs

protocol MyIntroDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MyIntroComponent: Component<MyIntroDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MyIntroBuildable: Buildable {
    func build(withListener listener: MyIntroListener) -> MyIntroRouting
}

final class MyIntroBuilder: Builder<MyIntroDependency>, MyIntroBuildable {

    override init(dependency: MyIntroDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MyIntroListener) -> MyIntroRouting {
        let component = MyIntroComponent(dependency: dependency)
        let viewController = MyIntroViewController()
        let interactor = MyIntroInteractor(presenter: viewController)
        interactor.listener = listener
        return MyIntroRouter(interactor: interactor, viewController: viewController)
    }
}

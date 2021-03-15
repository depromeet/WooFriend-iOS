//
//  ViewlessTestRibBuilder.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/16.
//

import RIBs

protocol ViewlessTestRibDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var ViewlessTestRibViewController: ViewlessTestRibViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class ViewlessTestRibComponent: Component<ViewlessTestRibDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var ViewlessTestRibViewController: ViewlessTestRibViewControllable {
        return dependency.ViewlessTestRibViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ViewlessTestRibBuildable: Buildable {
    func build(withListener listener: ViewlessTestRibListener) -> ViewlessTestRibRouting
}

final class ViewlessTestRibBuilder: Builder<ViewlessTestRibDependency>, ViewlessTestRibBuildable {

    override init(dependency: ViewlessTestRibDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ViewlessTestRibListener) -> ViewlessTestRibRouting {
        let component = ViewlessTestRibComponent(dependency: dependency)
        let interactor = ViewlessTestRibInteractor()
        interactor.listener = listener
        return ViewlessTestRibRouter(interactor: interactor, viewController: component.ViewlessTestRibViewController)
    }
}

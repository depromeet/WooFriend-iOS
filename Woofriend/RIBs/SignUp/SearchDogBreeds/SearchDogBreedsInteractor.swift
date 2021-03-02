//
//  SearchDogBreedsInteractor.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs
import RxSwift

protocol SearchDogBreedsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchDogBreedsPresentable: Presentable {
    var listener: SearchDogBreedsPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchDogBreedsListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchDogBreedsInteractor: PresentableInteractor<SearchDogBreedsPresentable>, SearchDogBreedsInteractable, SearchDogBreedsPresentableListener {

    weak var router: SearchDogBreedsRouting?
    weak var listener: SearchDogBreedsListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchDogBreedsPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

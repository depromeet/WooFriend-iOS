//
//  TestRespone.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/10.
//

import RxSwift

protocol TestResponeType: class {

    func test(auth: String) -> Single<NaverInfo>
}

final class TestRespone: TestResponeType {

    private let repository: TestRepositoy

    init(repository: TestRepositoy) {
        self.repository = repository
    }

    func test(auth: String) -> Single<NaverInfo> {
        return repository.getUserInfo(auth: auth)
    }
}

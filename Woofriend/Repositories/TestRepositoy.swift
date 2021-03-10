//
//  TestRepositoy.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/10.
//

import RxSwift
import Moya

protocol TestRepositoyType: class {

    func getUserInfo(auth: String) -> Single<NaverInfo>
}

final class TestRepositoy: TestRepositoyType {
    
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func getUserInfo(auth: String) -> Single<NaverInfo> {
        return self.apiClient.request(NaverLoginService.searchUser(auth)).map(NaverInfo.self)
            
    }
}

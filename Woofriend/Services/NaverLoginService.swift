//
//  NaverLoginService.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/10.
//

import Moya

//protocol NaverLoginService: TargetType, Hashable { }

//NaverLoginService

enum NaverLoginService {
    
    case searchUser(String)
}

extension NaverLoginService: TargetType, Hashable {
    
    var baseURL: URL {
        return URL(string: "https://openapi.naver.com/v1/nid/me")!
    }
    
    var headers: [String: String]? {
        switch self {
        case .searchUser(let authorization):
            return ["Authorization" : authorization]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var path: String {
        switch self {
        case .searchUser: return ""
        }
    }
    
    var method: Method {
        switch self {
        case .searchUser: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchUser:
            return .requestPlain
        }
    }
}


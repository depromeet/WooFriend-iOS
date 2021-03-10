//
//  NaverInfo.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/10.
//

import Foundation

struct NaverInfo {

    let resultcode: String
    let message: String
    let response: TESTT
}

// MARK: - Decodable
extension NaverInfo: Decodable {

    private enum CodingKeys: String, CodingKey {
        case resultcode
        case message
        case response
    }
}

extension NaverInfo: Hashable {

    static func == (_ lhs: NaverInfo, _ rhs: NaverInfo) -> Bool {
        return lhs.resultcode == rhs.resultcode
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(resultcode)
    }
}

struct TESTT {
    let id: String?
    let nickname: String?
    let profile_image: String?
    let gender: String?
    let name: String?
    let birthday: String?
}

extension TESTT: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case profile_image
        case gender
        case name
        case birthday
    }
}

extension TESTT: Hashable {

    static func == (_ lhs: TESTT, _ rhs: TESTT) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
//
//{
//    "resultcode": "00",
//    "message": "success",
//    "response": {
//        "id": "71626334",
//        "nickname": "Narr",
//        "profile_image": "https://ssl.pstatic.net/static/pwe/address/img_profile.png",
//        "gender": "M",
//        "name": "이규현",
//        "birthday": "02-27"
//    }
//}

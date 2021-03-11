//
//  Encodable+Extension.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/11.
//

import Foundation


extension Encodable {
    
    /**
     내부에서 관리하는 모델을 API로 실어 보내기 위해
     */
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return [: ]
        }

        return dictionary
    }
}


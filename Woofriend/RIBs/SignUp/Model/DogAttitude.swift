//
//  DogAttitude.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import Foundation

struct DogAttitude {
    
    var character: [String]?
    var Interest: [Bool]?
    
    func hasNilField() -> Bool {
        Mirror(reflecting: self).children.contains(where: {
            if case Optional<Any>.some(_) = $0.value {
                guard let str = $0.value as? String, str == "" else { return false }
                return true
            } else {
                return true
            }
        })
    }
    
}

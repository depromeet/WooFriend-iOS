//
//  DogBread.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/11.
//

import Foundation

struct DogBread {
    
    var bread: String?
    var isNeutered: Bool?
    var isVaccinated: Bool?
    
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

//
//  DogInfoParams.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/11.
//

import Foundation
import UIKit

// TODO: Encodable는 UIImage 안되넴 Hashable {
struct DogProfile {
    
    var name: String?
    var gender: String? // M, W
    var age: String?
    var photo: UIImage?
    
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

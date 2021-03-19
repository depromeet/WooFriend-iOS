//
//  MyProfile.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/19.
//

import Foundation
import UIKit

struct MyProfile {
    
    var photo: UIImage?
    var name: String?
    var gender: String? // M, W
    var year: String?
    var month: String?
    var day: String?
    var region: String?
    
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

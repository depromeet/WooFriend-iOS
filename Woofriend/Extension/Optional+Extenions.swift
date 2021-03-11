//
//  Optional+Extenions.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/11.
//

import Foundation

extension Optional where Wrapped == String {
    var nilIfEmpty: String? {
        guard let strongSelf = self else {
            return nil
        }
        return strongSelf.isEmpty ? nil : strongSelf
    }
}

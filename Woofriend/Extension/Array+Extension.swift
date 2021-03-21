//
//  Array+Extension.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/21.
//

import Foundation

public extension Array {
    subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}

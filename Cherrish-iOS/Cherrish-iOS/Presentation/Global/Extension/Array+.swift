//
//  Array+.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/12/26.
//

import Foundation

extension Array where Element == String {
    func joinedWithSeparator() -> String {
        self.joined(separator: " | ")
    }
}

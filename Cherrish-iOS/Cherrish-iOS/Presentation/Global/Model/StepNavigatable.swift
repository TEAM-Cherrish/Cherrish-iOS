//
//  StepNavigatable.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/19/26.
//

import Foundation

protocol StepNavigatable: CaseIterable, Identifiable, Equatable where AllCases: BidirectionalCollection, AllCases.Index == Int {
    var title: String { get }
}

extension StepNavigatable {
    var id: Self { self }
    var isFirst: Bool { self == Self.allCases.first }
    var isLast: Bool { self == Self.allCases.last }
    
    mutating func next() {
        let allCases = Array(Self.allCases)
        guard let currentIndex = allCases.firstIndex(of: self),
              currentIndex + 1 < allCases.count else { return }
        self = allCases[currentIndex + 1]
    }
    
    mutating func previous() {
        let allCases = Array(Self.allCases)
        guard let currentIndex = allCases.firstIndex(of: self),
              currentIndex > 0 else { return }
        self = allCases[currentIndex - 1]
    }
}

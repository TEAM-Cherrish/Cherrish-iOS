//
//  NoTreatment.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import Foundation

enum NoTreatment: Int, CaseIterable, Identifiable {
    case treatmentSelectedCategory = 1
    case targetDdaySetting
    case treatmentFilter
    case downTimeSetting
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .treatmentSelectedCategory:
            return "시술 카테고리 선택"
        case .targetDdaySetting:
            return "목표 디데이 설정"
        case .treatmentFilter:
            return "시술 필터링"
        case .downTimeSetting:
            return "다운타임 설정"
        }
    }
    
    var isFirst: Bool { self == Self.allCases.first }
    var isLast: Bool { self == Self.allCases.last }
}

// MARK: - Navigation
extension NoTreatment {
    mutating func next() {
        let allCases = Self.allCases
        guard let currentIndex = allCases.firstIndex(of: self),
              currentIndex + 1 < allCases.count else { return }
        self = allCases[allCases.index(after: currentIndex)]
    }
    
    mutating func previous() {
        let allCases = Self.allCases
        guard let currentIndex = allCases.firstIndex(of: self),
              currentIndex > 0 else { return }
        self = allCases[allCases.index(before: currentIndex)]
    }
}

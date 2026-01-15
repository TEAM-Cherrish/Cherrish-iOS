//
//  NoTreatmentViewModel.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/15/26.
//

import Foundation

enum NoTreatment: Int, CaseIterable {
    case tretmentSelectedCatagory = 1
    case targetDdaySetting
    case treatmentfilter
    case downTimeSetting
    
    var title: String {
        switch self {
        case .tretmentSelectedCatagory:
            return "시술 카테고리 선택"
        case .targetDdaySetting:
            return "목표 디데이 설정"
        case .treatmentfilter:
            return "시술 필터링"
        case .downTimeSetting:
            return "다운타임 설정"
        }
    }
}

enum TreatmentCatagory: CaseIterable {
    case textureKeratin
    case pigmentation
    case redness
    case wrinkle
    case pore
    case trouble
    
    var title: String {
        switch self {
        case .textureKeratin: 
            return "피부결 ∙ 각질"
        case .pigmentation:
            return "색소 ∙ 잡티"
        case .redness: 
            return "홍조"
        case .wrinkle: 
            return "탄력 ∙ 주름"
        case .pore:
            return "모공"
        case .trouble: 
            return "트러블"
        }
    }
}

private extension NoTreatment {
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

class NoTreatmentViewModel: ObservableObject{
    @Published var state: NoTreatment = .tretmentSelectedCatagory
    @Published var step: Int = 1
    @Published var treatmentCatagory: TreatmentCatagory? = nil
    @Published var dDay: DdayState? = nil
    @Published var year: String = ""
    @Published var month: String = ""
    @Published var day: String = ""
    
    
    func next() {
        if step < NoTreatment.allCases.count {
            state.next()
            step = state.rawValue
        }
    }
    
    func previous() {
        if step > 1 {
            state.previous()
            step = state.rawValue
        }
    }
    
    func isDateTextFieldNotEmpty() -> Bool {
        
        return !(year.isEmpty || month.isEmpty || day.isEmpty)
            
    }
    
    
}

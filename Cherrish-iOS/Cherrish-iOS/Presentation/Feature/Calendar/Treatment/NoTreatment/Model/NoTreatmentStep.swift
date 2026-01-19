//
//  NoTreatmentStep.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import Foundation

enum NoTreatmentStep: Int, StepNavigatable {
    case treatmentSelectedCategory = 1
    case targetDdaySetting
    case treatmentFilter
    case downTimeSetting
    
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
}

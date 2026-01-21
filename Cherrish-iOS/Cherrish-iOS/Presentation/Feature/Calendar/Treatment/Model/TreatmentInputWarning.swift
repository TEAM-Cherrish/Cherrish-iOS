//
//  TreatmentInputWarning.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/21/26.
//

import Foundation

enum TreatmentInputWarning {
    case none
    case pastDate
    case invalidFormat
    case beforeProcedureDate
    
    var message: String {
        switch self {
        case .none:
            return ""
        case .pastDate:
            return "이미 지난 날짜는 입력할 수 없어요."
        case .invalidFormat:
            return "올바른 날짜 형식이 아니에요."
        case .beforeProcedureDate:
            return "목표일은 시술 날짜 이후로만 설정할 수 있어요."
        }
    }
}

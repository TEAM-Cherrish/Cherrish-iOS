//
//  ProcedurePhase+.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/15/26.
//

import Foundation

extension ProcedurePhase {
    var displayText: String {
        switch self {
        case .sensitive:
            return "민감기"
        case .caution:
            return "주의기"
        case .recovery:
            return "회복기"
        }
    }
}

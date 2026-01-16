//
//  TreatmentCategory.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import Foundation

enum TreatmentCategory: CaseIterable, Identifiable {
    case textureKeratin
    case pigmentation
    case redness
    case wrinkle
    case pore
    case trouble
    var id: Self { self }
    
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

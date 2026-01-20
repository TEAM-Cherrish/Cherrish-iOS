//
//  RecentProcedureDTO.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/20/26.
//

import Foundation

struct RecentProcedureDTO: Decodable {
    let name: String
    let daysSince: Int
    let currentPhase: String
}

extension RecentProcedureDTO {
    func toEntity() -> RecentProcedureEntity {
        RecentProcedureEntity(
            name: name,
            daysSince: daysSince,
            currentPhase: convertToPhase(currentPhase)
        )
    }
    
    private func convertToPhase(_ phase: String) -> ProcedurePhase {
        switch phase {
        case "SENSITIVE":
            return .sensitive
        case "CAUTION":
            return .caution
        case "RECOVERY":
            return .recovery
        default:
            return .sensitive
        }
    }
}

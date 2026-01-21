//
//  TreatmentEntity.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/12/26.
//

import Foundation

struct TreatmentEntity: Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let benefits: [String]
    let downtimeMin: Int
    let downtimeMax: Int
    var setDowntime: Int?
    
    mutating func updateDowntime(_ value: Int) {
            setDowntime = value
        }
}

extension TreatmentEntity {
    func toRequestDTO() -> UserProcedureItemRequestDTO? {
        guard let downtime = setDowntime else { return nil }
        return UserProcedureItemRequestDTO(
            procedureId: id,
            downtimeDays: downtime
        )
    }
}


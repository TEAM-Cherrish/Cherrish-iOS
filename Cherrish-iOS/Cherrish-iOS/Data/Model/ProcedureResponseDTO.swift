//
//  ProcedureResponseDTO.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/20/26.
//

import Foundation

struct ProcedureDTO: Decodable {
    let id: Int
    let name: String
    let worries: [TreatmentCategoryResponseDTO]
    let minDowntimeDays: Int
    let maxDowntimeDays: Int
}

struct ProceduresResponseDTO: Decodable {
    let procedures: [ProcedureDTO]
}


extension ProcedureDTO {
    func toEntity() -> TreatmentEntity {
        return TreatmentEntity(
            id: id,
            name: name,
            benefits: worries.map {
                $0.toEntity().title
            },
            downtimeMin: minDowntimeDays,
            downtimeMax: maxDowntimeDays,
            setDowntime: nil
        )
    }
}

//
//  UpcomingProcedureDTO.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/18/26.
//

import Foundation

struct UpcomingProcedureDTO: Decodable {
    let date: String
    let name: String
    let count: Int
    let dDay: Int
}

extension UpcomingProcedureDTO {
    func toEntity() -> UpcomingProcedureEntity {
        UpcomingProcedureEntity(
            date: date,
            name: name,
            count: count,
            dDay: dDay
        )
    }
}

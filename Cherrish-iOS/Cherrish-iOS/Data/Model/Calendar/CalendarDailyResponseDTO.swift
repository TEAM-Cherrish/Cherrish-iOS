//
//  CalendarDailyResponseDTO.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/15/26.
//

import Foundation

struct CalendarDailyResponseDTO: Decodable {
    let events: [EventResponseDTO]
    let eventCount: Int
}

struct EventResponseDTO: Decodable {
    let type: String
    let userProcedureId: Int
    let procedureId: Int
    let name: String
    let scheduledAt: String
    let downtimeDays: Int
}

extension CalendarDailyResponseDTO {
    func toEntity() -> [DailyProcedureEntity] {
        events.map { event in
            .init(
                type: event.type,
                procedureId: event.userProcedureId,
                name: event.name,
                downtimeDays: event.downtimeDays
            )
        }
    }
}

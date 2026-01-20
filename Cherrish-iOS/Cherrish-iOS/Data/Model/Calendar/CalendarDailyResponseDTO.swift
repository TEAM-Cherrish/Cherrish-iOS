//
//  CalendarDailyResponseDTO.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/15/26.
//

import Foundation

struct CalendarDailyResponseDTO: Decodable {
    let eventCount: Int
    let events: [EventResponseDTO]
}

struct EventResponseDTO: Decodable {
    let type: String
    let id: Int
    let procedureId: Int
    let name: String
    let scheduledAt: String
    let downtimeDays: Int
    let sensitiveDays: [String]
    let cautionDays: [String]
    let recoveryDays: [String]
}

extension CalendarDailyResponseDTO {
    func toEntity() {
        
    }
}

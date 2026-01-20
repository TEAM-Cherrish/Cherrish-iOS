//
//  DashboardDTO.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/18/26.
//

import Foundation

struct DashboardDTO: Decodable {
    let date: String
    let dayOfWeek: String
    let challengeName: String?
    let cherryLevel: Int
    let challengeRate: Double
    let recentProcedures: [RecentProcedureDTO]
    let upcomingProcedures: [UpcomingProcedureDTO]
}

extension DashboardDTO {
    func toEntity() -> DashboardEntity {
        DashboardEntity(
            date: date,
            dayOfWeek: dayOfWeek,
            challengeName: challengeName,
            cherryLevel: cherryLevel,
            challengeRate: challengeRate,
            recentProcedures: recentProcedures.map { $0.toEntity() },
            upcomingProcedures: upcomingProcedures.map { $0.toEntity() }
        )
    }
}

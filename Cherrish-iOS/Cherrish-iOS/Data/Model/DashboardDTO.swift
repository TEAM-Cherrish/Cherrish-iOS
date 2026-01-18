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

struct RecentProcedureDTO: Decodable {
    let name: String
    let daysSince: Int
    let currentPhase: String
}

struct UpcomingProcedureDTO: Decodable {
    let date: String
    let name: String
    let count: Int
    let dDay: Int
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

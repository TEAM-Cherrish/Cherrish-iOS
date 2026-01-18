//
//  DashboardEntity.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/15/26.
//

import Foundation

struct DashboardEntity {
    let date: String
    let dayOfWeek: String
    let challengeName: String
    let cherryLevel: Int
    let challengeRate: Double
    let recentProcedures: [RecentProcedureEntity]
    let upcomingProcedures: [UpcomingProcedureEntity]
}

struct RecentProcedureEntity {
    let name: String
    let daysSince: Int
    let currentPhase: ProcedurePhase
}

struct UpcomingProcedureEntity {
    let date: String
    let name: String
    let count: Int
    let dDay: Int
}

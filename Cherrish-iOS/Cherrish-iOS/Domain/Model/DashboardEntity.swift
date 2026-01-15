//
//  DashboardEntity.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/15/26.
//

import Foundation

struct DashboardEntity {
    let date: String
    let challengeName: String
    let cherryLevel: Int
    let challengeRate: Double
    let recentProcedure: RecentProcedureEntity?
    let upcomingProcedures: [UpcomingProcedureEntity]?
}

struct RecentProcedureEntity {
    let name: String
    let scheduledAt: String
    let daysSince: Int
    let currentPhase: ProcedurePhase
}

struct UpcomingProcedureEntity: Identifiable {
    let id: Int
    let name: String
    let scheduledAt: String
    let dDay: Int
}

enum ProcedurePhase {
    case sensitive
    case recovery
    case normal
    
    var displayText: String {
        switch self {
        case .sensitive:
            return "민감기"
        case .recovery:
            return "회복기"
        case .normal:
            return "정상기"
        }
    }
}

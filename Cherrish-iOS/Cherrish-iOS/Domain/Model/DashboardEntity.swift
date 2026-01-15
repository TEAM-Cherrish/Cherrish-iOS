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
<<<<<<< HEAD
    let upcomingProcedures: [UpcomingProcedureEntity]?
=======
    let upcomingProcedures: [UpcomingProcedureEntity]
>>>>>>> 95c9770 (feat: #49 클린아키텍쳐)
}

struct RecentProcedureEntity {
    let name: String
    let scheduledAt: String
    let daysSince: Int
<<<<<<< HEAD
    let currentPhase: ProcedurePhase
=======
    let currentPhase: ProcedurePhaseType
>>>>>>> 95c9770 (feat: #49 클린아키텍쳐)
}

struct UpcomingProcedureEntity: Identifiable {
    let id: Int
    let name: String
    let scheduledAt: String
    let dDay: Int
}

<<<<<<< HEAD
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
=======
enum ProcedurePhaseType: String {
    case sensitive = "SENSITIVE"
    case caution = "CAUTION"
    case recovery = "RECOVERY"
    case completed = "COMPLETED"
    
    var displayText: String {
        switch self {
        case .sensitive: return "민감기"
        case .caution: return "주의기"
        case .recovery: return "회복기"
        case .completed: return "완료"
>>>>>>> 95c9770 (feat: #49 클린아키텍쳐)
        }
    }
}

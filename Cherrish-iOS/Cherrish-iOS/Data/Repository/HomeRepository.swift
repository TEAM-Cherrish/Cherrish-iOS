//
//  HomeRepository.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/15/26.
//

import Foundation

struct DefaultHomeRepository: HomeInterface {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchDashboard() async throws -> DashboardEntity {
        return createMockDashboard()
    }
    
    private func createMockDashboard() -> DashboardEntity {
        DashboardEntity(
            date: "2026-01-15",
            dayOfWeek: "WEDNESDAY",
            challengeName: "피부 컨디션 챌린지",
            cherryLevel: 4,
            challengeRate: 87.5,
            recentProcedures: [
                RecentProcedureEntity(
                    name: "레이저 토닝",
                    daysSince: 3,
                    currentPhase: .sensitive
                ),
                RecentProcedureEntity(
                    name: "보습 케어",
                    daysSince: 5,
                    currentPhase: .caution
                ),
                RecentProcedureEntity(
                    name: "필러",
                    daysSince: 8,
                    currentPhase: .recovery
                )
            ],
            upcomingProcedures: [
                UpcomingProcedureEntity(
                    date: "2026-01-20",
                    name: "보톡스",
                    count: 2,
                    dDay: 5
                ),
                UpcomingProcedureEntity(
                    date: "2026-01-25",
                    name: "필러",
                    count: 1,
                    dDay: 10
                )
            ]
        )
    }
}

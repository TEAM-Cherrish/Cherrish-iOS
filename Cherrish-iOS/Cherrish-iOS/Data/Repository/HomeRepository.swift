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
            challengeName: "피부 컨디션 챌린지",
            cherryLevel: 3,
            challengeRate: 40.3,
            recentProcedure: RecentProcedureEntity(
                name: "레이저 토닝",
                scheduledAt: "2026-01-12T14:00:00",
                daysSince: 3,
                currentPhase: .sensitive
            ),
            upcomingProcedures: [
                UpcomingProcedureEntity(
                    id: 123,
                    name: "보톡스",
                    scheduledAt: "2026-01-20T16:00:00",
                    dDay: 5
                ),
                UpcomingProcedureEntity(
                    id: 124,
                    name: "필러",
                    scheduledAt: "2026-01-25T15:00:00",
                    dDay: 10
                ),
                UpcomingProcedureEntity(
                    id: 125,
                    name: "울쎄라",
                    scheduledAt: "2026-02-01T14:00:00",
                    dDay: 17
                )
            ]
        )
    }
}

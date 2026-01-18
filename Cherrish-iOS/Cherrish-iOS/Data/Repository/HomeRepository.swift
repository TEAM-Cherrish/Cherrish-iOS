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
        fatalError("Not implemented")
    }

}

struct MockHomeRepository: HomeInterface {
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
            challengeName: "피부컨디션 챌린지",
            cherryLevel: 0,
            challengeRate: 80.1,
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
                ),
                RecentProcedureEntity(
                    name: "필러",
                    daysSince: 8,
                    currentPhase: .recovery
                )
                ,
                RecentProcedureEntity(
                    name: "필러",
                    daysSince: 8,
                    currentPhase: .recovery
                )
                ,
                RecentProcedureEntity(
                    name: "필러",
                    daysSince: 8,
                    currentPhase: .recovery
                )
                ,
                RecentProcedureEntity(
                    name: "필러",
                    daysSince: 8,
                    currentPhase: .recovery
                )
            ],
            upcomingProcedures: [
                
            ]
        )
    }
}

//
//  FetchDashboardData.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/15/26.
//

import Foundation

protocol FetchDashboardData {
    func execute() async throws -> DashboardEntity
}

struct DefaultFetchDashboardData: FetchDashboardData {
    private let repository: HomeInterface
    
    init(repository: HomeInterface) {
        self.repository = repository
    }
    
    func execute() async throws -> DashboardEntity {
        try await repository.fetchDashboard()

    }
}

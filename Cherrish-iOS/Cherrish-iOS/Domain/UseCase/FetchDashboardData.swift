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
<<<<<<< HEAD
        try await repository.fetchDashboard()
=======
        return try await repository.fetchDashboard()
>>>>>>> 95c9770 (feat: #49 클린아키텍쳐)
    }
}

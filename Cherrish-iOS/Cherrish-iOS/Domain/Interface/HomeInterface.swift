//
//  HomeInterface.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/15/26.
//

import Foundation

protocol HomeInterface {
    func fetchDashboard() async throws -> DashboardEntity
}

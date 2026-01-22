//
//  HomeViewModel.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/15/26.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var dashboardData: DashboardEntity?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let fetchDashboardDataUseCase: FetchDashboardData
    private let homeCalendarFlowState: HomeCalendarFlowState
    
    init(
        fetchDashboardDataUseCase: FetchDashboardData,
        homeCalendarFlowState: HomeCalendarFlowState
    ) {
        self.fetchDashboardDataUseCase = fetchDashboardDataUseCase
        self.homeCalendarFlowState = homeCalendarFlowState
    }
    
    @MainActor
    func loadDashboard() async {
        isLoading = true
        errorMessage = nil
        
        do {
            dashboardData = try await fetchDashboardDataUseCase.execute()

        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func selectUpcomingDate(_ dateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            homeCalendarFlowState.treatmentDate = date
        }
    }
    
    var formattedDate: String {
        guard let date = dashboardData?.date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let parsedDate = formatter.date(from: date) else { return date }
        
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일 (E)"
        return formatter.string(from: parsedDate)
    }
    
    var challengeRateText: String {
        guard let rate = dashboardData?.challengeRate else { return "0%" }
        return String(format: "%.0f%%", rate)
    }
    
    var challengeName: String? {
        return dashboardData?.challengeName
    }
    
    var cherryLevel: Int {
        dashboardData?.cherryLevel ?? 0
    }
    
    var challengeBarImageName: String {
        let level = cherryLevel 
        return "home_chellenge_bar\(level)"
    }
    
    var cherryLevelImageName: String {
        let level = cherryLevel == 0 ? 1 : cherryLevel
        return "home_lv.\(level)"
    }
    
    var allMonthPlanItems: [MonthPlanItem] {
        guard let recentProcedures = dashboardData?.recentProcedures else { return [] }
        return recentProcedures.enumerated().map { index, procedure in
            MonthPlanItem(
                id: "\(procedure.name)_\(procedure.daysSince)_\(index)",
                name: procedure.name,
                dayCount: procedure.daysSince,
                tag: procedure.currentPhase.displayText
            )
        }
    }
    
    var upcomingItems: [UpcomingItem] {
        guard let upcoming = dashboardData?.upcomingProcedures else { return [] }
        return upcoming.enumerated().map { index, group in
            UpcomingItem(
                id: "\(group.date)_\(index)",
                date: group.date,
                name: group.name,
                count: group.count,
                dDay: group.dDay
            )
        }
    }
}

struct MonthPlanItem: Identifiable {
    let id: String
    let name: String
    let dayCount: Int
    let tag: String
}

struct UpcomingItem: Identifiable {
    let id: String
    let date: String
    let name: String
    let count: Int
    let dDay: Int
}

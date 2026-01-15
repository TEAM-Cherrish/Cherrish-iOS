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
    
    private let fetchDashboardData: FetchDashboardData
    
    init(fetchDashboardData: FetchDashboardData) {
        self.fetchDashboardData = fetchDashboardData
    }
    
    init() {
        guard let useCase = DIContainer.shared.resolve(type: FetchDashboardData.self) else {
            fatalError("FetchDashboardData is not registered in DIContainer")
        }
        self.fetchDashboardData = useCase
    }
    
    @MainActor
    func loadDashboard() async {
        isLoading = true
        errorMessage = nil
        
        do {
            dashboardData = try await fetchDashboardData.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
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
    
    var challengeName: String {
        dashboardData?.challengeName ?? "챌린지"
    }
    
    var cherryLevel: Int {
        dashboardData?.cherryLevel ?? 1
    }
    
    var challengeBarImageName: String {
        let level = min(max(cherryLevel, 1), 4)
        return "home_chellenge_bar\(level)"
    }
    
    var cherryLevelImageName: String {
        let level = min(max(cherryLevel, 0), 4)
        return "home_lv.\(level)"
    }
    
    var allMonthPlanItems: [MonthPlanItem] {
        var items: [MonthPlanItem] = []
        
        if let recent = dashboardData?.recentProcedure {
            items.append(MonthPlanItem(
                id: 0,
                name: recent.name,
                dayCount: recent.daysSince,
                tag: recent.currentPhase.displayText,
                isRecent: true
            ))
        }
        
        if let upcoming = dashboardData?.upcomingProcedures {
            items.append(contentsOf: upcoming.map { procedure in
                MonthPlanItem(
                    id: procedure.id,
                    name: procedure.name,
                    dayCount: procedure.dDay,
                    tag: "D-\(procedure.dDay)",
                    isRecent: false
                )
            })
        }
        
        return items
    }
}

struct MonthPlanItem: Identifiable {
    let id: Int
    let name: String
    let dayCount: Int
    let tag: String
    let isRecent: Bool
}

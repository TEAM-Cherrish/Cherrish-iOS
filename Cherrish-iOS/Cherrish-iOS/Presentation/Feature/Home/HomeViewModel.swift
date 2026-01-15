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
<<<<<<< HEAD
        guard let useCase = DIContainer.shared.resolve(type: FetchDashboardData.self) else {
            fatalError("FetchDashboardData is not registered in DIContainer")
        }
        self.fetchDashboardData = useCase
=======
        if let useCase = DIContainer.shared.resolve(type: FetchDashboardData.self) {
            self.fetchDashboardData = useCase
        } else {
            self.fetchDashboardData = MockFetchDashboardData()
        }
>>>>>>> 95c9770 (feat: #49 클린아키텍쳐)
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
    
<<<<<<< HEAD
    var cherryLevelImageName: String {
        let level = min(max(cherryLevel, 0), 4)
        return "home_lv.\(level)"
    }
    
=======
>>>>>>> 95c9770 (feat: #49 클린아키텍쳐)
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
<<<<<<< HEAD
=======

private struct MockFetchDashboardData: FetchDashboardData {
    func execute() async throws -> DashboardEntity {
        DashboardEntity(
            date: "2026-01-15",
            challengeName: "피부 컨디션 챌린지",
            cherryLevel: 1,
            challengeRate: 40.3,
            recentProcedure: RecentProcedureEntity(
                name: "레이저 토닝",
                scheduledAt: "2026-01-12T14:00:00",
                daysSince: 3,
                currentPhase: .sensitive
            ),
            upcomingProcedures: [
                UpcomingProcedureEntity(id: 123, name: "보톡스", scheduledAt: "2026-01-20T16:00:00", dDay: 5),
                UpcomingProcedureEntity(id: 124, name: "필러", scheduledAt: "2026-01-25T15:00:00", dDay: 10),
                UpcomingProcedureEntity(id: 125, name: "울쎄라", scheduledAt: "2026-02-01T14:00:00", dDay: 17)
            ]
        )
    }
}
>>>>>>> 95c9770 (feat: #49 클린아키텍쳐)

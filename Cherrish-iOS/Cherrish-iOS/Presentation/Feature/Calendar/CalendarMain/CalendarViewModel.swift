//
//  CalendarViewModel.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/12/26.
//

import Foundation

struct DateValue: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var day: Int
    var date: Date
}

final class CalendarViewModel: ObservableObject {
    @Published private(set) var currentDate: Date = Date()
    @Published var currentMonth: Int = 0
    @Published var selectedDate: Date = Calendar.current.startOfDay(for: Date())
    @Published private(set) var procedureCountOfMonth: [Int: Int] = [:]
    @Published private(set) var procedureList: [DailyProcedureEntity] = []
    @Published private(set) var treatmentDate: String = ""
    @Published private(set) var downtimeByDay: [String : DowntimeDayState] = [:]
    @Published private(set) var selectedDowntime: ProcedureDowntimeEntity?
    
    private let fetchProcedureCountOfMonthUseCase: FetchProcedureCountOfMonth
    private let fetchTodayProcedureListUseCase: FetchTodayProcedureListUseCase
    private let fetchProcedureDowntimeUseCase: FetchProcedureDowntimeUseCase
    private let calendarTreatmentFlowState: CalendarTreatmentFlowState
    
    init(
        fetchProcedureCountOfMonthUseCase: FetchProcedureCountOfMonth,
        fetchTodayProcedureListUseCase: FetchTodayProcedureListUseCase,
        fetchProcedureDowntimeUseCase: FetchProcedureDowntimeUseCase,
        calendarTreatmentFlowState: CalendarTreatmentFlowState
    ) {
        self.fetchProcedureCountOfMonthUseCase = fetchProcedureCountOfMonthUseCase
        self.fetchTodayProcedureListUseCase = fetchTodayProcedureListUseCase
        self.calendarTreatmentFlowState = calendarTreatmentFlowState
        self.fetchProcedureDowntimeUseCase = fetchProcedureDowntimeUseCase
    }
    
    func confirmDate() {
        calendarTreatmentFlowState.selectedDaet = selectedDate
    }
    
    func select(date: Date) {
        selectedDate = date
    }
    
    func isSelected(_ value: DateValue) -> Bool {
        return Calendar.current.isDate(value.date, inSameDayAs: selectedDate)
    }
    
    func getYearAndMonthString() -> String {
        let targetDate = getCurrentMonth(addingMonth: currentMonth)
        let calendar = Calendar.current
        let year = calendar.component(.year, from: targetDate)
        let month = calendar.component(.month, from: targetDate)
        return "\(year)년 \(month)월"
    }
    
    func getDatesArray() -> [DateValue] {
        return extractDate(currentMonth: currentMonth)
    }
    
    func getProcedureCount(for value: DateValue) -> Int {
        guard value.day != -1 else { return 0 }
        return procedureCountOfMonth[value.day] ?? 0
    }
    
    func firstDateOfCurrentMonth() -> Date {
        let calendar = Calendar.current
        let targetDate = getCurrentMonth(addingMonth: currentMonth)
        
        let components = calendar.dateComponents([.year, .month], from: targetDate)
        return calendar.date(from: components) ?? targetDate
    }
    
    func getDowntimeState(for date: Date) -> DowntimeDayState {
        let key = date.toDateString()
        return downtimeByDay[key] ?? .none
    }
    
    func isDDay(for date: Date, selectedProcedureID: Int) -> Bool {
        guard let selectedDowntime, selectedDowntime.procedureId == selectedProcedureID else { return false }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        guard let targetDate = formatter.date(from: selectedDowntime.recoveryTargetDate) else { return false }
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        
        let result = calendar.isDate(date, inSameDayAs: targetDate)
        return result
    }
    
    func isEmptyProcedureList() -> Bool {
        return procedureList.isEmpty
    }
    
    func sendDateToTreatmentView() {
        calendarTreatmentFlowState.selectedDaet = selectedDate
    }
    
    @MainActor
    func fetchProcedureCountsOfMonth() async throws {
        let calendar = Calendar.current
        let targetDate = getCurrentMonth(addingMonth: currentMonth)
        let year = calendar.component(.year, from: targetDate)
        let month = calendar.component(.month, from: targetDate)
        
        let response = try await fetchProcedureCountOfMonthUseCase.execute(year: year, month: month)
        procedureCountOfMonth = response.dailyProcedureCounts
    }
    
    @MainActor
    func fetchTodayProcedureList() async throws {
        treatmentDate = selectedDate.toDateString()
        procedureList = try await fetchTodayProcedureListUseCase.execute(date: treatmentDate)
    }
    
    @MainActor
    func fetchDowntimeByDay(procedureId: Int) async throws {
        let downtimeList = try await fetchProcedureDowntimeUseCase.execute(id: procedureId)
        selectedDowntime = downtimeList
        mapToDowntimeDays(procedure: downtimeList)
    }
}

extension CalendarViewModel {
    private func getCurrentMonth(addingMonth: Int) -> Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        
        guard let currentMonth = calendar.date(
            byAdding: .month,
            value: addingMonth,
            to: Date()
        ) else {
            return Date()
        }
        
        return currentMonth
    }
    
    private func extractDate(currentMonth: Int) -> [DateValue] {
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth(addingMonth: currentMonth)
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0 ..< firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
    private func mapToDowntimeDays(procedure: ProcedureDowntimeEntity) {
        var map: [String : DowntimeDayState] = [:]
        procedure.sensitiveDays.forEach { map[$0] = .sensitive }
        procedure.cautionDays.forEach { map[$0] = .caution }
        procedure.recoveryDays.forEach { map[$0] = .recovery }
        downtimeByDay = map
    }
}

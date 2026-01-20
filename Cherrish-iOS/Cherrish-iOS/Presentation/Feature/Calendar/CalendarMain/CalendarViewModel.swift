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
    @Published private(set) var procedureList: [ProcedureEntity] = []
    @Published private(set) var downtimeByDay: [String : DowntimeDayState] = [:]
    
    private let fetchProcedureCountOfMonthUseCase: FetchProcedureCountOfMonth
    private let fetchTodayProcedureListUseCase: FetchTodayProcedureList
    private let calendarTreatmentFlowState: CalendarTreatmentFlowState
    
    init(
        fetchProcedureCountOfMonthUseCase: FetchProcedureCountOfMonth,
        fetchTodayProcedureListUseCase: FetchTodayProcedureList,
        calendarTreatmentFlowState: CalendarTreatmentFlowState
    ) {
        self.fetchProcedureCountOfMonthUseCase = fetchProcedureCountOfMonthUseCase
        self.fetchTodayProcedureListUseCase = fetchTodayProcedureListUseCase
        self.calendarTreatmentFlowState = calendarTreatmentFlowState
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
        
        procedureCountOfMonth = try await fetchProcedureCountOfMonthUseCase.execute(year: year, month: month)
    }
    
    @MainActor
    func fetchTodayProcedureList() async throws {
        procedureList = try await fetchTodayProcedureListUseCase.execute(date: selectedDate.toDateString())
        CherrishLogger.debug(procedureList)
    }
    
    func fetchDowntimeByDay(procedureId: Int) {
        guard let procedure = procedureList.first(where: { $0.procedureId == procedureId }) else {
            downtimeByDay = [:]
            return
        }
        mapToDowntimeDays(procedure: procedure)
    }
}

extension CalendarViewModel {
    private func getCurrentMonth(addingMonth: Int) -> Date {
        let calendar = Calendar.current
        
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
    
    private func mapToDowntimeDays(procedure: ProcedureEntity) {
        var map: [String : DowntimeDayState] = [:]
        procedure.sensitiveDays.forEach { map[$0] = .sensitive }
        procedure.cautionDays.forEach { map[$0] = .caution }
        procedure.recoveryDays.forEach { map[$0] = .recovery }
        downtimeByDay = map
        CherrishLogger.debug(downtimeByDay)
    }
}

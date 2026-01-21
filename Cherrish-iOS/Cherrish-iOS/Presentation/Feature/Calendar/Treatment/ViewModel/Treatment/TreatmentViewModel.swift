//
//  TreatmentViewModel.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import SwiftUI
import Combine

final class TreatmentViewModel: ObservableObject{
    @Published private(set) var treatments: [TreatmentEntity] = []
    @Published var selectedTreatments: [TreatmentEntity] = []
    @Published var state: TreatmentStep = .targetDdaySetting
    @Published var dDay: DdayState?
    @Published var year: String = ""
    @Published var month: String = ""
    @Published var day: String = ""
    @Published var searchText = ""
    
    private let fetchTreatmentsUseCase: FetchTreatmentsUseCase
    private let createUserProcedureUseCase: CreateUserProcedureUseCase
    private let calendarTreatmentFlowState: CalendarTreatmentFlowState
    
    
    init(
        fetchTreatmentsUseCase: FetchTreatmentsUseCase,
        calendarTreatmentFlowState: CalendarTreatmentFlowState,
        createUserProcedureUseCase: CreateUserProcedureUseCase
    ) {
        self.fetchTreatmentsUseCase = fetchTreatmentsUseCase
        self.createUserProcedureUseCase = createUserProcedureUseCase
        self.calendarTreatmentFlowState = calendarTreatmentFlowState
    }

    
    var step: Int { state.rawValue }
    
    var today: (year: Int, month: Int, day: Int) {
        let calendar = Calendar.current
        let now = Date()
        return (
            calendar.component(.year, from: now),
            calendar.component(.month, from: now),
            calendar.component(.day, from: now)
        )
    }
    
    var canProceed: Bool {
        switch state {
        case .targetDdaySetting:
            return isDateTextFieldNotEmpty()
        case .treatmentFilter:
            return !selectedTreatments.isEmpty
        case .downTimeSetting:
            return selectedTreatments.allSatisfy { $0.setDowntime != nil }
            
        }
    }
    
    @MainActor
    func fetchTreatments() async throws {
        do {
            treatments = try await fetchTreatmentsUseCase.execute(id: nil, keyword: searchText)
        } catch {
            treatments = []
        }
    }
    
    
    func createUserProcedure() async throws {
        guard let scheduledDate = calendarTreatmentFlowState.selectedDaet else {
            return
        }
        
        guard let recoverDate = Date.from(year: year, month: month, day: day) else {
            return
        }
        
        do {
            try await createUserProcedureUseCase.excute(scheduledDate: scheduledDate.toScheduledAtFormat, recoveryDate: recoverDate.toRecoveryDateFormat, treatments: selectedTreatments)
        } catch {
            CherrishLogger.network(CherrishError.networkRequestFailed)
        }
    }
    
    func next() {
        state.next()
    }
    
    func previous() {
        state.previous()
    }
    
    func toInt(_ value: String) -> Int {
        Int(value) ?? 0
    }
    
    func isDateTextFieldNotEmpty() -> Bool {
        guard !year.isEmpty, !month.isEmpty, !day.isEmpty else {
            return false
        }
        
        guard let yearInt = Int(year), yearInt >= 2020,
              let monthInt = Int(month), (1...12).contains(monthInt),
              let dayInt = Int(day), (1...31).contains(dayInt) else {
            return false
        }
        
        let components = DateComponents(year: yearInt, month: monthInt, day: dayInt)
        
        guard let date = Calendar.current.date(from: components),
              Calendar.current.dateComponents([.year, .month, .day], from: date) == components else {
            return false
        }
        
        return true
    }
}


extension TreatmentViewModel {
    
    func addTreatment(_ treatment: TreatmentEntity) {
        guard !isSelected(treatment) else { return }
        selectedTreatments.append(treatment)
    }
    
    func removeTreatment(_ treatment: TreatmentEntity) {
        selectedTreatments.removeAll { $0.id == treatment.id }
    }
    func isSelected(_ treatment: TreatmentEntity) -> Bool {
        selectedTreatments.contains(where: { $0.id == treatment.id })
    }
}

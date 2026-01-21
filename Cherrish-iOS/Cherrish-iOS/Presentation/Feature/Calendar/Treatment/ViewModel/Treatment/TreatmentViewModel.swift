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
    @Published private(set) var warning: TreatmentInputWarning = .none
    
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
        guard let scheduledDate = calendarTreatmentFlowState.selectedDate else {
            return
        }
        
        guard let recoverDate = Date.from(year: year, month: month, day: day) else {
            return
        }
        
        do {
            try await createUserProcedureUseCase.execute(scheduledDate: scheduledDate.toScheduledAtFormat, recoveryDate: recoverDate.toRecoveryDateFormat, treatments: selectedTreatments)
        } catch {
            CherrishLogger.network(error)
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
            Task { @MainActor in
                updateWarning(state: .none)
            }
            return false
        }
        
        guard let y = Int(year), let m = Int(month), let d = Int(day) else {
            updateWarning(state: .invalidFormat)
            return false
        }
           
        let components = DateComponents(year: y, month: m, day: d)
        
        guard let date = Calendar.current.date(from: components),
              Calendar.current.dateComponents([.year, .month, .day], from: date) == components else {
            updateWarning(state: .invalidFormat)
            return false
        }
        
        let today = Calendar.current.startOfDay(for: Date())
        if date < today {
            updateWarning(state: .pastDate)
            return false
        }
        
        updateWarning(state: .none)
        return true
    }
    
  
    private func updateWarning(state: TreatmentInputWarning) {
        Task { @MainActor in
            warning = state
        }
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

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
    private let calendarTreatmentFlowState: CalendarTreatmentFlowState
    
    init(
        fetchTreatmentsUseCase: FetchTreatmentsUseCase,
        calendarTreatmentFlowState: CalendarTreatmentFlowState
    ) {
        self.fetchTreatmentsUseCase = fetchTreatmentsUseCase
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
              let monthInt = Int(month), monthInt >= 1, monthInt <= 12,
              let dayInt = Int(day), dayInt >= 1, dayInt <= 31 else {
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

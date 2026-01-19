//
//  TreatmentViewModel.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import SwiftUI
import Combine

final class TreatmentViewModel: ObservableObject{
    @Published var state: TreatmentStep = .targetDdaySetting
    @Published var dDay: DdayState?
    @Published var year: String = ""
    @Published var month: String = ""
    @Published var day: String = ""
    @Published var treatments: [TreatmentEntity] = TreatmentEntity.mockData
    @Published var selectedTreatments: [TreatmentEntity] = []
    @Published var searchText = ""
    @Published var filteredTreatments: [TreatmentEntity] = []
    
    var step: Int { state.rawValue }
    
    var cancellables = Set<AnyCancellable>()
    
    var today: (year: Int, month: Int, day: Int) {
        let calendar = Calendar.current
        let now = Date()
        return (
            calendar.component(.year, from: now),
            calendar.component(.month, from: now),
            calendar.component(.day, from: now)
        )
    }
    
    init() {
        filteredTreatments = treatments
               setupSearch()
    }
    var canProceed: Bool {
           switch state {
           case .targetDdaySetting:
               return isDateTextFieldNotEmpty()
           case .treatmentFilter:
               return !selectedTreatments.isEmpty
           case .downTimeSetting:
               return true
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

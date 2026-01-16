//
//  NoTreatmentViewModel.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/15/26.
//

import Foundation

final class NoTreatmentViewModel: ObservableObject{
    @Published var state: NoTreatment = .treatmentSelectedCategory
    var step: Int { state.rawValue }
    @Published var treatmentCatagory: TreatmentCategory?
    @Published var dDay: DdayState?
    @Published var year: String = ""
    @Published var month: String = ""
    @Published var day: String = ""
    @Published var Treatments: [TreatmentEntity] = TreatmentEntity.mockData
    @Published var selectedTreatments: [TreatmentEntity] = []
    var canProceed: Bool {
           switch state {
           case .treatmentSelectedCategory:
               return treatmentCatagory != nil
           case .targetDdaySetting:
               return isDateTextFieldNotEmpty()
           case .treatmentFilter:
               return true
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

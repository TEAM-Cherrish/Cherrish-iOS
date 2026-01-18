//
//  NoTreatmentViewModel.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/15/26.
//

import Foundation

final class NoTreatmentViewModel: ObservableObject{
    @Published var state: NoTreatment = .treatmentSelectedCategory
    @Published var treatmentCatagory: TreatmentCategory?
    @Published var dDay: DdayState?
    @Published var year: String = ""
    @Published var month: String = ""
    @Published var day: String = ""
    @Published var treatments: [TreatmentEntity] = TreatmentEntity.mockData
    @Published var selectedTreatments: [TreatmentEntity] = []
    
    var step: Int { state.rawValue }
    
    var canProceed: Bool {
           switch state {
           case .treatmentSelectedCategory:
               return treatmentCatagory != nil
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

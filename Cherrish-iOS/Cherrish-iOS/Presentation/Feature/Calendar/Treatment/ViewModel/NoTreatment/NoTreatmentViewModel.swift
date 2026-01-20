//
//  NoTreatmentViewModel.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/15/26.
//

import Foundation

final class NoTreatmentViewModel: ObservableObject{
    @Published var state: NoTreatmentStep = .treatmentSelectedCategory
    @Published private(set) var categories: [TreatmentCategoryEntity] = []
    @Published private(set) var selectedCategory: TreatmentCategoryEntity?
    @Published var dDay: DdayState?
    @Published var year: String = ""
    @Published var month: String = ""
    @Published var day: String = ""
    @Published private(set) var treatments: [TreatmentEntity] = []
    @Published private(set) var selectedTreatments: [TreatmentEntity] = []
    
    private let fetchCategoriesUseCase: FetchTreatmentCategoriesUseCase
    private let fetchTreatmentsUseCase: FetchTreatmentsUseCase
    
    var step: Int { state.rawValue }
    
    var canProceed: Bool {
        switch state {
        case .treatmentSelectedCategory:
            return selectedCategory != nil
        case .targetDdaySetting:
            return isDateTextFieldNotEmpty()
        case .treatmentFilter:
            return !selectedTreatments.isEmpty
        case .downTimeSetting:
            return true
        }
    }
    
    init(fetchCategoriesUseCase: FetchTreatmentCategoriesUseCase, fetchTreatmentsUseCase: FetchTreatmentsUseCase) {
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
        self.fetchTreatmentsUseCase = fetchTreatmentsUseCase
    }
    
    var today: (year: Int, month: Int, day: Int) {
        let calendar = Calendar.current
        let now = Date()
        return (
            calendar.component(.year, from: now),
            calendar.component(.month, from: now),
            calendar.component(.day, from: now)
        )
    }
    
    func next() {
        state.next()
    }
    
    func previous() {
        state.previous()
    }
    
    @MainActor
    func loadCategories() async {
        do {
            categories = try await fetchCategoriesUseCase.execute()
        } catch {
            
        }
    }
    
    @MainActor
    func testfetchTreatments() async {
        do {
            treatments = try await fetchTreatmentsUseCase.execute(id: nil, keyword: "")
        } catch {
            treatments = []
        }
    }
    
    func selectCategory(_ category: TreatmentCategoryEntity) {
        selectedCategory = category
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


extension NoTreatmentViewModel {
    
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

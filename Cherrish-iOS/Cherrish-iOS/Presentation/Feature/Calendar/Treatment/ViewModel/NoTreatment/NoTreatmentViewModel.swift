//
//  NoTreatmentViewModel.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/15/26.
//

import Foundation

final class NoTreatmentViewModel: ObservableObject{
    @Published private(set) var categories: [TreatmentCategoryEntity] = []
    @Published private(set) var selectedCategory: TreatmentCategoryEntity?
    @Published private(set) var treatments: [TreatmentEntity] = []
    @Published var selectedTreatments: [TreatmentEntity] = []
    @Published var state: NoTreatmentStep = .treatmentSelectedCategory
    @Published var dDay: DdayState?
    @Published var year: String = ""
    @Published var month: String = ""
    @Published var day: String = ""
    @Published private(set) var warning: TreatmentInputWarning = .none
    
    private let fetchCategoriesUseCase: FetchTreatmentCategoriesUseCase
    private let fetchTreatmentsUseCase: FetchTreatmentsUseCase
    
    init(fetchCategoriesUseCase: FetchTreatmentCategoriesUseCase, fetchTreatmentsUseCase: FetchTreatmentsUseCase) {
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
        self.fetchTreatmentsUseCase = fetchTreatmentsUseCase
    }
    
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
            return selectedTreatments.allSatisfy { $0.setDowntime != nil }
        }
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
    func fetchCategories() async {
        do {
            categories = try await fetchCategoriesUseCase.execute()
        } catch {
            
        }
    }
    
    @MainActor
    func fetchNoTreatments() async {
        do {
            treatments = try await fetchTreatmentsUseCase.execute(id: selectedCategory?.id, keyword: "")
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

//
//  PresentationDependencyAssembler.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/5/26.
//

import Foundation

final class PresentationDependencyAssembler: DependencyAssembler {
    private let preAssembler: DependencyAssembler
    
    init(preAssembler: DependencyAssembler) {
        self.preAssembler = preAssembler
    }
    
    func assemble() {
        preAssembler.assemble()
        
        DIContainer.shared.register(type: CalendarTreatmentFlowState.self) {
            return CalendarTreatmentFlowState()
        }
        
        guard let createProfileUseCase = DIContainer.shared.resolve(type: CreateProfileUseCase.self) else {
            CherrishLogger.error(CherrishError.DIFailedError)
            return
        }
        
        DIContainer.shared.register(type: OnboardingViewModel.self) {
            return OnboardingViewModel(createProfileUseCase: createProfileUseCase)
        }
        
        guard let fetchProcedureCountOfMonthUseCase = DIContainer.shared.resolve(type: FetchProcedureCountOfMonth.self),
              let fetchTodayProcedureListUseCase = DIContainer.shared.resolve(type: FetchTodayProcedureList.self)
        else {
            CherrishLogger.error(CherrishError.DIFailedError)
            return
        }
        
        guard let calendarTreatmentFlowState = DIContainer.shared.resolve(type: CalendarTreatmentFlowState.self) else {
            CherrishLogger.error(CherrishError.DIFailedError)
            return
        }
        
        DIContainer.shared.register(type: CalendarViewModel.self) {
            return CalendarViewModel(
                fetchProcedureCountOfMonthUseCase: fetchProcedureCountOfMonthUseCase,
                fetchTodayProcedureListUseCase: fetchTodayProcedureListUseCase,
                calendarTreatmentFlowState: calendarTreatmentFlowState
            )
        }
        
        guard let fetchDashboardData = DIContainer.shared.resolve(type: FetchDashboardData.self) else {
            return
        }
        
        DIContainer.shared.register(type: HomeViewModel.self) {
            return HomeViewModel(fetchDashboardDataUseCase: fetchDashboardData)
        }
        
        guard let fetchTreatmentCategoriesUseCase = DIContainer.shared.resolve(type: FetchTreatmentCategoriesUseCase.self) else {
            CherrishLogger.error(CherrishError.DIFailedError)
            return
        }
        
        guard let fetchTreatmentsUseCase = DIContainer.shared.resolve(type: FetchTreatmentsUseCase.self) else {
            return
        }
        
        DIContainer.shared.register(type: SelectTreatmentViewModel.self) {
            return SelectTreatmentViewModel()
        }
        
        DIContainer.shared.register(type: NoTreatmentViewModel.self) {
            return NoTreatmentViewModel(
                fetchCategoriesUseCase: fetchTreatmentCategoriesUseCase,
                fetchTreatmentsUseCase: fetchTreatmentsUseCase,
                calendarTreatmentFlowState: calendarTreatmentFlowState
            )
        }
        
        
        DIContainer.shared.register(type: TreatmentViewModel.self) {
            return TreatmentViewModel(
                fetchTreatmentsUseCase: fetchTreatmentsUseCase,
                calendarTreatmentFlowState: calendarTreatmentFlowState
            )
        }
    }
}

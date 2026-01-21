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
        
        let calendarTreatmentFlowState = CalendarTreatmentFlowState()
        DIContainer.shared.register(type: CalendarTreatmentFlowState.self) {
            return calendarTreatmentFlowState
        }
        
        let homeCalendarFlowState = HomeCalendarFlowState()
        DIContainer.shared.register(type: HomeCalendarFlowState.self) {
            return homeCalendarFlowState
        }
        
        guard let createProfileUseCase = DIContainer.shared.resolve(type: CreateProfileUseCase.self) else {
            CherrishLogger.error(CherrishError.DIFailedError)
            return
        }
        
        DIContainer.shared.register(type: OnboardingViewModel.self) {
            return OnboardingViewModel(createProfileUseCase: createProfileUseCase)
        }
        
        guard let fetchProcedureCountOfMonthUseCase = DIContainer.shared.resolve(type: FetchProcedureCountOfMonth.self),
            let fetchTodayProcedureListUseCase = DIContainer.shared.resolve(type: FetchTodayProcedureListUseCase.self),
              let fetchProcedureDowntimeUseCase = DIContainer.shared.resolve(type: FetchProcedureDowntimeUseCase.self)
        else {
            CherrishLogger.error(CherrishError.DIFailedError)
            return
        }
        
        DIContainer.shared.register(type: CalendarViewModel.self) {
            return CalendarViewModel(
                fetchProcedureCountOfMonthUseCase: fetchProcedureCountOfMonthUseCase,
                fetchTodayProcedureListUseCase: fetchTodayProcedureListUseCase,
                fetchProcedureDowntimeUseCase: fetchProcedureDowntimeUseCase,
                calendarTreatmentFlowState: calendarTreatmentFlowState
            )
        }
        
        guard let fetchDashboardData = DIContainer.shared.resolve(type: FetchDashboardData.self) else {
            return
        }
        
        DIContainer.shared.register(type: HomeViewModel.self) {
            return HomeViewModel(
                fetchDashboardDataUseCase: fetchDashboardData,
                homeCalendarFlowState: homeCalendarFlowState
            )
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
        
        
        
        guard let createUserProcedureUseCase = DIContainer.shared.resolve(type: CreateUserProcedureUseCase.self) else {
            return
        }
        
        DIContainer.shared.register(type: NoTreatmentViewModel.self) {
            return NoTreatmentViewModel(
                fetchCategoriesUseCase: fetchTreatmentCategoriesUseCase,
                fetchTreatmentsUseCase: fetchTreatmentsUseCase,
                calendarTreatmentFlowState: calendarTreatmentFlowState,
                createUserProcedureUseCase: createUserProcedureUseCase
            )
        }
        
        DIContainer.shared.register(type: TreatmentViewModel.self) {
            return TreatmentViewModel(
                fetchTreatmentsUseCase: fetchTreatmentsUseCase,
                calendarTreatmentFlowState: calendarTreatmentFlowState,
                createUserProcedureUseCase: createUserProcedureUseCase
            )
        }
        
        guard let fetchUserInfoUseCase = DIContainer.shared.resolve(type: FetchUserInfoUseCase.self) else {
            return
        }
        
        DIContainer.shared.register(type: MyPageViewModel.self) {
            return MyPageViewModel(fetchUserInfoUseCase: fetchUserInfoUseCase)
        }

        guard let fetchChallengeHomecareRoutines = DIContainer.shared.resolve(type: FetchChllengeHomecareRoutinesUseCase.self) else {
            return
        }
        guard let postChallengeRecommendUseCase = DIContainer.shared.resolve(type: PostChallengeRecommendUseCase.self) else {
            return
        }

        guard let createChallengeUseCase = DIContainer.shared.resolve(type: CreateChallengeUseCase.self) else {
            return
        }

        DIContainer.shared.register(type: CreateChallengeViewModel.self) {
            return CreateChallengeViewModel(fetchRoutineUseCase: fetchChallengeHomecareRoutines, postChallengeRecommendUseCase:  postChallengeRecommendUseCase, createChallengeUseCase: createChallengeUseCase)
        }

        guard let fetchChallengeUseCase = DIContainer.shared.resolve(type: FetchChallengeUseCase.self),
              let toggleRoutineUseCase = DIContainer.shared.resolve(type: ToggleRoutineUseCase.self),
              let advanceDayUseCase = DIContainer.shared.resolve(type: AdvanceDayUseCase.self)
        else {
            CherrishLogger.error(CherrishError.DIFailedError)
            return
        }

        DIContainer.shared.register(type: ChallengeProgressViewModel.self) {
            return ChallengeProgressViewModel(
                fetchChallengeUseCase: fetchChallengeUseCase,
                toggleRoutineUseCase: toggleRoutineUseCase,
                advanceDayUseCase: advanceDayUseCase
            )
        }
    }

}

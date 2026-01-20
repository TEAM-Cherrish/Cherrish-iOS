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
        
        DIContainer.shared.register(type: OnboardingViewModel.self) {
            return OnboardingViewModel()
        }
        
        guard let fetchProcedureCountOfMonthUseCase = DIContainer.shared.resolve(type: FetchProcedureCountOfMonth.self),
            let fetchTodayProcedureListUseCase = DIContainer.shared.resolve(type: FetchTodayProcedureList.self)
        else {
            CherrishLogger.error(CherrishError.DIFailedError)
            return
        }
        
        DIContainer.shared.register(type: CalendarViewModel.self) {
            return CalendarViewModel(
                fetchProcedureCountOfMonthUseCase: fetchProcedureCountOfMonthUseCase,
                fetchTodayProcedureListUseCase: fetchTodayProcedureListUseCase
            )
        }
        
        guard let fetchDashboardData = DIContainer.shared.resolve(type: FetchDashboardData.self) else {
            return
        }
        
        DIContainer.shared.register(type: HomeViewModel.self) {
            return HomeViewModel(fetchDashboardDataUseCase: fetchDashboardData)
        }
        
        
        DIContainer.shared.register(type: NoTreatmentViewModel.self) {
            let repository = MockTreatmentRepository()
            let useCase = DefaultFetchTreatmentCategoriesUseCase(repository: repository)
            return NoTreatmentViewModel(fetchCategoriesUseCase: useCase)
        }
        
        guard let fetchChallengeHomecareRoutines = DIContainer.shared.resolve(type: FetchChllengeHomecareRoutinesUseCase.self) else {
            return
        }
        guard let submitChallengRecommendUseCase = DIContainer.shared.resolve(type: SubmitChallengRecommendUseCase.self) else {
            return
        }

        DIContainer.shared.register(type: MakeChallengeViewModel.self) {
            return MakeChallengeViewModel(fetchRoutineUseCase: fetchChallengeHomecareRoutines, postChallengeRecommendUseCase: submitChallengRecommendUseCase)
        }
    }

}

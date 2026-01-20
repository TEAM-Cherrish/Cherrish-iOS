//
//  DomainDependencyAssembler.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/5/26.
//

import Foundation

final class DomainDependencyAssembler: DependencyAssembler {
    private let preAssembler: DependencyAssembler
    
    init(preAssembler: DependencyAssembler) {
        self.preAssembler = preAssembler
    }
    
    func assemble() {
        preAssembler.assemble()

        guard let calendarRepository = DIContainer.shared.resolve(type: CalendarInterface.self) else {
            return
        }
        
        DIContainer.shared.register(type: FetchProcedureCountOfMonth.self) {
            return DefaultFetchProcedureCountOfMonth(repository: calendarRepository)
        }
        
        guard let homeRepository = DIContainer.shared.resolve(type: HomeInterface.self) else {
            return
        }
        
        DIContainer.shared.register(type: FetchDashboardData.self) {
            return DefaultFetchDashboardData(repository: homeRepository)
        }
    
        DIContainer.shared.register(type: FetchTodayProcedureList.self) {
            return DefaultFetchTodayProcedure(repository: calendarRepository)
        }
        
        guard let treatmentCategoryRepository = DIContainer.shared.resolve(type: TreatmentInterface.self) else {
            return
        }
        
        DIContainer.shared.register(type: FetchTreatmentCategoriesUseCase.self) {
            return DefaultFetchTreatmentCategoriesUseCase(repository: treatmentCategoryRepository)
        }
        
        guard let challengeRepository = DIContainer.shared.resolve(type: ChallengeInterface.self) else {
            return
        }
        
        DIContainer.shared.register(type: FetchChllengeHomecareRoutinesUseCase.self) {
            return DefaultFetchChallengeHomecareRoutinesUseCase(repository: challengeRepository)
        }
        

        DIContainer.shared.register(type: SubmitChallengRecommendUseCase.self) {
            return DefaultSubmitChallengRecommendUseCase(repository: challengeRepository)
        }
        
    }
}

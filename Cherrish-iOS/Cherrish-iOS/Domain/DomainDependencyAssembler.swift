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
        
        guard let homeRepository = DIContainer.shared.resolve(type: HomeInterface.self) else {
            return
        }
        
        guard let treatmentCategoryRepository = DIContainer.shared.resolve(type: TreatmentInterface.self) else {
            return
        }
        
        DIContainer.shared.register(type: FetchProcedureCountOfMonth.self) {
            return DefaultFetchProcedureCountOfMonth(repository: calendarRepository)
        }
        
        DIContainer.shared.register(type: FetchTodayProcedureListUseCase.self) {
            return DefaultFetchTodayProcedureUseCase(repository: calendarRepository)
        }
        
        guard let homeRepository = DIContainer.shared.resolve(type: HomeInterface.self) else {
            return
        }
        
        DIContainer.shared.register(type: FetchProcedureDowntimeUseCase.self) {
            return DefaultFetchProcedureDowntimeUseCase(repository: calendarRepository)
        }
        
        DIContainer.shared.register(type: FetchDashboardData.self) {
            return DefaultFetchDashboardData(repository: homeRepository)
        }
        
        guard let onboardingRepository = DIContainer.shared.resolve(type: OnboardingInterface.self) else {
            return
        }
        
        DIContainer.shared.register(type: CreateProfileUseCase.self) {
            return DefaultCreateProfileUseCase(repository: onboardingRepository)
        }
        
        guard let treatmentRepository = DIContainer.shared.resolve(type: TreatmentInterface.self) else {
            return
        }
        
        DIContainer.shared.register(type: FetchTreatmentCategoriesUseCase.self) {
            return DefaultFetchTreatmentCategoriesUseCase(repository: treatmentRepository)
        }
        
        DIContainer.shared.register(type: FetchTreatmentsUseCase.self) {
            return DefaultFetchTreatmentsUseCase(repository: treatmentRepository)
        }
        
        guard let myPageRepository = DIContainer.shared.resolve(type: MyPageInterface.self) else {
            return
        }
        
        DIContainer.shared.register(type: FetchUserInfoUseCase.self) {
            return DefaultFetchUserInfoUserCase(repository: myPageRepository)
        }
    }
}

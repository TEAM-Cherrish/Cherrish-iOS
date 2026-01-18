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

        guard let testRepository = DIContainer.shared.resolve(type: TestInterface.self) else {
            return
        }
        
        DIContainer.shared.register(type: TestUseCase.self) {
            return DefaultTestUseCase(repository: testRepository)
        }
        
        guard let homeRepository = DIContainer.shared.resolve(type: HomeInterface.self) else {
            return
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
    }
}

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
        
<<<<<<< HEAD
        guard let networkService = DIContainer.shared.resolve(type: NetworkService.self) else {
            return
        }
        
        let homeRepository = DefaultHomeRepository(networkService: networkService)
        
        DIContainer.shared.register(type: HomeInterface.self) {
            return homeRepository
        }
        
=======
        // Home UseCase
        guard let homeRepository = DIContainer.shared.resolve(type: HomeInterface.self) else {
            return
        }
        
>>>>>>> 95c9770 (feat: #49 클린아키텍쳐)
        DIContainer.shared.register(type: FetchDashboardData.self) {
            return DefaultFetchDashboardData(repository: homeRepository)
        }
    }
}

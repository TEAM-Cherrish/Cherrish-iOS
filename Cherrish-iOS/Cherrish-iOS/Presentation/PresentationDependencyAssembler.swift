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
        
        guard let fetchProcedureCountOfMonthUseCase = DIContainer.shared.resolve(type: FetchProcedureCountOfMonth.self) else {
            CherrishLogger.error(CherrishError.DIFailedError)
            return
        }
        
        DIContainer.shared.register(type: CalendarViewModel.self) {
            return CalendarViewModel(fetchProcedureCountOfMonthUseCase: fetchProcedureCountOfMonthUseCase)
        }
        
        guard let fetchDashboardData = DIContainer.shared.resolve(type: FetchDashboardData.self) else {
            return
        }
        
        DIContainer.shared.register(type: HomeViewModel.self) {
            return HomeViewModel(fetchDashboardDataUseCase: fetchDashboardData)
        }
    }
}

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
        
//        guard let testUseCase = DIContainer.shared.resolve(type: TestUseCase.self) else {
//            return
//        }
//        
//        DIContainer.shared.register(type: TestViewModel.self) {
//            print("뷰모델 등록")
//            return TestViewModel(testUseCase: testUseCase)
//        }
//        
        DIContainer.shared.register(type: OnboardingViewModel.self) {
            return OnboardingViewModel()
        }
        
        guard let fetchDashboardData = DIContainer.shared.resolve(type: FetchDashboardData.self) else {
            return
        }
        
        DIContainer.shared.register(type: HomeViewModel.self) {
            return HomeViewModel(fetchDashboardData: fetchDashboardData)
        }
    }
    
    
}

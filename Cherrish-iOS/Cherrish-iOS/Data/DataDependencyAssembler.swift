//
//  DataDependencyAssembler.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/5/26.
//

import Foundation

final class DataDependencyAssembler: DependencyAssembler {
    private let networkService: NetworkService
    private let userDefaultService: UserDefaultService
    
    init() {
        self.networkService = DefaultNetworkService()
        self.userDefaultService = DefaultUserDefaultService()
    }

    func assemble() {
        DIContainer.shared.register(type: CalendarInterface.self) {
            return DefaultCalendarRepository(
                networkService: self.networkService,
                userDefaultService: self.userDefaultService
            )
        }

        DIContainer.shared.register(type: HomeInterface.self) {
            return DefaultHomeRepository(
                networkService: self.networkService,
                userDefaultService: self.userDefaultService
            )
        }
        
        DIContainer.shared.register(type: OnboardingInterface.self) {
            return DefaultOnboardingRepository(
                networkService: self.networkService,
                userDefaultService: self.userDefaultService
            )
        }
         
        DIContainer.shared.register(type: TreatmentInterface.self) {
            return DefaultTreatmentRepository(networkService: self.networkService, userDefaultService: self.userDefaultService)
        }
        DIContainer.shared.register(type: ChallengeInterface.self) {
            return DefaultChallengeRepository(
                networkService: self.networkService, userDefaultService: self.userDefaultService)
        }

        DIContainer.shared.register(type: DemoInterface.self) {
            return DefaultDemoRepository(
                networkService: self.networkService,
                userDefaultService: self.userDefaultService
            )
        }
        
        DIContainer.shared.register(type: MyPageInterface.self) {
            return DefaultMyPageRepository(
                networkService: self.networkService,
                userDefaultService: self.userDefaultService
            )
        }
    }
}

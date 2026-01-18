//
//  DataDependencyAssembler.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/5/26.
//

import Foundation

final class DataDependencyAssembler: DependencyAssembler {
    private let networkService: NetworkService
    
    init() {
        self.networkService = DefaultNetworkService()
    }
    
    func assemble() {
        DIContainer.shared.register(type: CalendarInterface.self) {
            return MockCalendarRepository()
        }
        
        DIContainer.shared.register(type: HomeInterface.self) {
            return DefaultHomeRepository(networkService: self.networkService)
        }
    }
}

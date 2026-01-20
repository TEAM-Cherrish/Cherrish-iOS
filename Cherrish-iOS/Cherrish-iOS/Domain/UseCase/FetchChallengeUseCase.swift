//
//  FetchChallengeUseCase.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/21/26.
//

import Foundation

protocol FetchChallengeUseCase {
    func execute() async throws -> ChallengeEntity
}

struct DefaultFetchChallengeUseCase: FetchChallengeUseCase {
    private let repository: DemoInterface
    
    init(repository: DemoInterface) {
        self.repository = repository
    }
    
    func execute() async throws -> ChallengeEntity {
        try await repository.fetchChallenges()
    }
}

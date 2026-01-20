//
//  SubmitChallengRecommendUseCase.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/20/26.
//

import Foundation

protocol SubmitChallengRecommendUseCase {
    func excute(id: Int) async throws -> [ChallengeMissionEntity]
}

struct DefaultSubmitChallengRecommendUseCase: SubmitChallengRecommendUseCase {
    
    private let repository: ChallengeInterface
    
    init(repository: ChallengeInterface) {
        self.repository = repository
    }
    
    func excute(id: Int) async throws -> [ChallengeMissionEntity] {
        return try await repository.aiRecommendations(id: id)
    }
}

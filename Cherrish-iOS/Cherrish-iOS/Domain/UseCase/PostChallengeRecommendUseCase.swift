//
//  PostChallengeRecommendUseCase.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/20/26.
//

import Foundation

protocol PostChallengeRecommendUseCase {
    func excute(id: Int) async throws -> [ChallengeMissionEntity]
}

struct DefaultSubmitChallengRecommendUseCase: PostChallengeRecommendUseCase {

    private let repository: ChallengeInterface

    init(repository: ChallengeInterface) {
        self.repository = repository
    }

    func excute(id: Int) async throws -> [ChallengeMissionEntity] {
        return try await repository.aiRecommendations(id: id)
    }
}

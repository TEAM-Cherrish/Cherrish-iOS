//
//  CreateChallengeUseCase.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/21/26.
//

import Foundation

protocol CreateChallengeUseCase {
    func execute(id: Int, routines: [String]) async throws
}

struct DefaultCreateChallengeUseCase: CreateChallengeUseCase {
    private let repository: ChallengeInterface
    
    init(repository: ChallengeInterface) {
        self.repository = repository
    }
    
    func execute(id: Int, routines: [String]) async throws {
        let _ = try await repository.createChallenge(missionIds: id, routineNames: routines)
    }
}

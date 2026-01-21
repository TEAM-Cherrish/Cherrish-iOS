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
    private let repository: DemoInterface

    init(repository: DemoInterface) {
        self.repository = repository
    }

    func execute(id: Int, routines: [String]) async throws {
        _ = try await repository.createChallenge(missionIds: id, routineNames: routines)
    }
}

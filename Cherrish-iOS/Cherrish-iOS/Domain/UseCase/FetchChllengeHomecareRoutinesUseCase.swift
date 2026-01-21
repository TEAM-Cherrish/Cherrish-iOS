//
//  FetchChllengeHomecareRoutinesUseCase.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/20/26.
//

import Foundation

protocol FetchChllengeHomecareRoutinesUseCase {
    func excute() async throws -> [RoutineEntity]
}

struct DefaultFetchChallengeHomecareRoutinesUseCase: FetchChllengeHomecareRoutinesUseCase {

    private let repository: ChallengeInterface

    init(repository: ChallengeInterface) {
        self.repository = repository
    }
    func excute() async throws -> [RoutineEntity] {
        return try await repository.fetchHomecareRoutines()
    }
}

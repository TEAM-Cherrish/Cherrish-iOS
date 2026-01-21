//
//  AdvanceDayUseCase.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/21/26.
//

import Foundation

protocol AdvanceDayUseCase {
    func execute() async throws -> ProgressChallengeEntity
}

struct DefaultAdvanceDayUseCase: AdvanceDayUseCase {
    private let repository: DemoInterface

    init(repository: DemoInterface) {
        self.repository = repository
    }

    func execute() async throws -> ProgressChallengeEntity {
        try await repository.advance()
    }
}

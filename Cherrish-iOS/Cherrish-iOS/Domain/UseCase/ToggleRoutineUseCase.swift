//
//  ToggleRoutineUseCase.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/21/26.
//

import Foundation

protocol ToggleRoutineUseCase {
    func execute(routineID: Int) async throws -> ProgressRoutineEntity
}

struct DefaultToggleRoutineUseCase: ToggleRoutineUseCase {
    private let repository: DemoInterface

    init(repository: DemoInterface) {
        self.repository = repository
    }

    func execute(routineID: Int) async throws -> ProgressRoutineEntity {
        try await repository.toggleRoutine(routineID: routineID)
    }
}

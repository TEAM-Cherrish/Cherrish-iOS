//
//  CreateUserProcedureUseCase.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/21/26.
//

import Foundation

protocol CreateUserProcedureUseCase {
    func execute(scheduledDate: String, recoveryDate: String, treatments: [TreatmentEntity]) async throws
}

struct DefaultCreateUserProcedureUseCase: CreateUserProcedureUseCase {
    
    private let repository: TreatmentInterface
    
    init(repository: TreatmentInterface) {
        self.repository = repository
    }
    
    func execute(
        scheduledDate: String,
        recoveryDate: String,
        treatments: [TreatmentEntity]
    ) async throws {
        return try await repository
            .createUserProcedure(
                scheduledDate: scheduledDate,
                recoveryDate: recoveryDate,
                treatments: treatments
            )
    }
}

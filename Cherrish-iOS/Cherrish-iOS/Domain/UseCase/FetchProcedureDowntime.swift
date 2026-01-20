//
//  FetchProcedureDowntime.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/20/26.
//

import Foundation

protocol FetchProcedureDowntimeUseCase {
    func execute(id: Int) async throws -> ProcedureDowntimeEntity
}

struct DefaultFetchProcedureDowntimeUseCase: FetchProcedureDowntimeUseCase {
    private let repository: CalendarInterface
    
    init(repository: CalendarInterface) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> ProcedureDowntimeEntity {
        return try await repository.fetchProcedureDowntime(id: id)
    }
}

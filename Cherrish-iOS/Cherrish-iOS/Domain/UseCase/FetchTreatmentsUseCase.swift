//
//  FetchTreatmentsUseCase.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/20/26.
//

import Foundation

protocol FetchTreatmentsUseCase {
    func execute(id: Int?, keyword: String?) async throws -> [TreatmentEntity]
}

struct DefaultFetchTreatmentsUseCase: FetchTreatmentsUseCase {

    private let repository: TreatmentInterface
    
    init(repository: TreatmentInterface) {
        self.repository = repository
    }
    
    func execute(id: Int?, keyword: String?) async throws -> [TreatmentEntity] {
        return try await repository.fetchTreatment(id: id, keyword: keyword)
    }
}

//
//  FetchTreatmentCategoriesUseCaseImpl.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/19/26.
//

import Foundation

protocol FetchTreatmentCategoriesUseCase {
    func execute() async throws -> [TreatmentCategoryEntity]
}

struct FetchTreatmentCategoriesUseCaseImpl: FetchTreatmentCategoriesUseCase {
    private let repository: TreatmentInterface
    
    init(repository: TreatmentInterface) {
        self.repository = repository
    }
    
    func execute() async throws -> [TreatmentCategoryEntity] {
        return try await repository.fetchCategories()
    }
}

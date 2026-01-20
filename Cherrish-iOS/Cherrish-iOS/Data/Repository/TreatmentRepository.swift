//
//  TreatmentRepository.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/19/26.
//

import Foundation

struct DefaultTreatmentRepository: TreatmentInterface {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
 
    func fetchCategories() async throws -> [TreatmentCategoryEntity] {
        return []
    }
    
    func fetchTreatment(id: Int?, keyword: String?) async throws -> [TreatmentEntity] {
        let response = try await networkService.request(TreatmentAPI.fetchProcedures(id: id, text: keyword), decodingType: ProceduresResponseDTO.self)
        return response.procedures.map { $0.toEntity() }
    }
}

struct MockTreatmentRepository: TreatmentInterface {
    func fetchTreatment(id: Int?, keyword: String?) async throws -> [TreatmentEntity] {
        return []
    }
    
    func fetchCategories() async throws -> [TreatmentCategoryEntity] {
        return [
            TreatmentCategoryEntity(id: 1, title: "피부결 ∙ 각질"),
            TreatmentCategoryEntity(id: 2, title: "색소 ∙ 잡티"),
            TreatmentCategoryEntity(id: 3, title: "홍조"),
            TreatmentCategoryEntity(id: 4, title: "탄력 ∙ 주름"),
            TreatmentCategoryEntity(id: 5, title: "모공"),
            TreatmentCategoryEntity(id: 6, title: "트러블")
        ]
    }
}

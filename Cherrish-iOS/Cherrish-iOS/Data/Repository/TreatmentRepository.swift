//
//  TreatmentRepository.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/19/26.
//

import Foundation

struct DefaultTreatmentRepository: TreatmentInterface {
    func fetchCategories() async throws -> [TreatmentCategoryEntity] {
        return []
    }
}

struct MockTreatmentRepository: TreatmentInterface {
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

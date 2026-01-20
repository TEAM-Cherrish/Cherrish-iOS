//
//  TreatmentCategoryInterface.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/19/26.
//

import Foundation

protocol TreatmentInterface {
    func fetchCategories() async throws -> [TreatmentCategoryEntity]
    func fetchTreatment(id: Int?, keyword: String?) async throws -> [TreatmentEntity]
}

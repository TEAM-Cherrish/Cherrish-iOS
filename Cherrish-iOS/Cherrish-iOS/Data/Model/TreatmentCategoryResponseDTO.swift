//
//  TreatmentCategoryDTO.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/19/26.
//

import Foundation

struct TreatmentCategoryResponseDTO: Decodable {
    let id: Int
    let content: String
}

extension TreatmentCategoryResponseDTO {
    func toEntity() -> TreatmentCategoryEntity {
          return TreatmentCategoryEntity(
              id: id,
              title: content
          )
      }
}

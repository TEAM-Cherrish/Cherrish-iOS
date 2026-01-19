//
//  TreatmentCategoryDTO.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/19/26.
//

import Foundation

struct TreatmentCategoryDTO: Decodable {
    let id: Int
    let content: String
}

extension TreatmentCategoryDTO {
    func toEntity() -> TreatmentCategoryEntity {
          return TreatmentCategoryEntity(
              id: id,
              title: content
          )
      }
}


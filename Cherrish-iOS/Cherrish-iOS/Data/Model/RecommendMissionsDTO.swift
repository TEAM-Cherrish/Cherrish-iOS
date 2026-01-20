//
//  RecommendMissionsDTO.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/20/26.
//

import Foundation

struct RecommendMissionsDTO: Decodable {
    let title: String
}

extension RecommendMissionsDTO {
    func toEntity() -> ChallengeMissionEntity {
        ChallengeMissionEntity(title: title)
    }
}

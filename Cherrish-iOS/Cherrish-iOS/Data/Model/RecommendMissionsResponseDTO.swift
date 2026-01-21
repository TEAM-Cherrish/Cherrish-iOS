//
//  RecommentMisssionsResponseDTO.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/20/26.
//

import Foundation

struct RecommendMissionsResponseDTO: Decodable {
    let routines: [String]
}

extension RecommendMissionsResponseDTO {
    func toEntities() -> [ChallengeMissionEntity] {
        return routines.enumerated().map { index, title in
            ChallengeMissionEntity(id: index, title: title)
        }
    }
}

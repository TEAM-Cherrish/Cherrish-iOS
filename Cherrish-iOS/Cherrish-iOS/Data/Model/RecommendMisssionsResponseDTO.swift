//
//  RecommentMisssionsResponseDTO.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/20/26.
//

import Foundation

struct RecommendMisssionsResponseDTO: Decodable {
    let routines: [String]
}

extension RecommendMisssionsResponseDTO {
    func toEntities() -> [ChallengeMissionEntity] {
        return routines.enumerated().map { index, title in
            ChallengeMissionEntity(id: index, title: title)
        }
    }
}

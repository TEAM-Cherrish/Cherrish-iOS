//
//  ChallengeRoutineDTO.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/19/26.
//

import Foundation

struct ChallengeRoutineDTO: Decodable {
    let id: Int
    let name: String
    let description: String
}

extension ChallengeRoutineDTO {
    func toEntity() -> RoutineEntity {
        RoutineEntity(
            id: id,
            name: name,
            description: description
        )        
    }
}

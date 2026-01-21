//
//  ChallengeRoutineRequestDTO.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/19/26.
//

import Foundation

struct ChallengeRoutineRequestDTO: Decodable {
    let id: Int
    let name: String
    let description: String
}

extension ChallengeRoutineRequestDTO {
    func toEntity() -> RoutineEntity {
        RoutineEntity(
            id: id,
            name: name,
            description: description
        )        
    }
}

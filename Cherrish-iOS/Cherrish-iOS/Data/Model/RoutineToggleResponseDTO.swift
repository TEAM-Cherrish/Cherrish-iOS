//
//  RoutineToggleResponseDTO.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/21/26.
//

import Foundation

struct RoutineToggleResponseDTO: Decodable {
    let routineId: Int
    let name: String
    let isComplete: Bool
}

extension RoutineToggleResponseDTO {
    func toEntity() -> ProgressRoutineEntity {
        .init(
            routineID: routineId,
            name: name,
            isComplete: isComplete
        )
    }
}

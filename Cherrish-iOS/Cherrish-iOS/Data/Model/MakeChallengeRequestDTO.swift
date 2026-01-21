//
//  MakeChallengeRequestDTO.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/21/26.
//

import Foundation

struct MakeChallengeRequestDTO: Encodable {
    let homecareRoutineId: Int
    let routineNames: [String]
}

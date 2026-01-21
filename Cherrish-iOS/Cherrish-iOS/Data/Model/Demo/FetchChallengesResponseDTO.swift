//
//  FetchChallengesResponseDTO.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/21/26.
//

import Foundation

struct FetchChallengesResponseDTO: Decodable {
    let challengeId: Int
    let title: String
    let currentDay: Int
    let progressPercentage: Int
    let cherryLevel: Int
    let cherryLevelName: String
    let progressToNextLevel: Double
    let remainingRoutinesToNextLevel: Int
    let todayRoutines: [RoutineResponseDTO]
    let cheeringMessage: String
}

struct RoutineResponseDTO: Decodable {
    let routineId: Int
    let name: String
    let scheduledDate: String
    let isComplete: Bool
}

extension FetchChallengesResponseDTO {
    func toEntity() -> ProgressChallengeEntity {
        .init(
            challengeID: challengeId,
            title: title,
            currentDay: currentDay,
            progressPercentage: progressPercentage,
            cherryLevel: cherryLevel,
            cherryLevelName: cherryLevelName,
            progressToNextLevel: progressToNextLevel,
            remainingRoutinesToNextLevel: remainingRoutinesToNextLevel,
            todayRoutines: todayRoutines.map { $0.toEntity() }
        )
    }
}

extension RoutineResponseDTO {
    func toEntity() -> ProgressRoutineEntity {
        .init(
            routineID: routineId,
            name: name,
            isComplete: isComplete
        )
    }
}

//
//  ChallengeEntity.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/21/26.
//

import Foundation

struct ChallengeEntity {
    let challengeID: Int
    let title: String
    let currentDay: Int
    let progressPercentage: Int
    let cherryLevel: Int
    let cherryLevelName: String
    let progressToNextLevel: Double
    let remainingRoutinesToNextLevel: Int
    let todayRoutines: [RoutineEntity]
}

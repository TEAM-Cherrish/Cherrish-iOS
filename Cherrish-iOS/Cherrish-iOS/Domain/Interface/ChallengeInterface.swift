//
//  ChallengeInterface.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/19/26.
//

import Foundation

protocol ChallengeInterface {
    func fetchHomecareRoutines() async throws -> [RoutineEntity]
    func aiRecommendations(id: Int) async throws -> [ChallengeMissionEntity]
}

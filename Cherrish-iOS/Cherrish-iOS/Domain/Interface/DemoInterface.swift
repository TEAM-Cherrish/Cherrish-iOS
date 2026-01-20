//
//  DemoInterface.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/21/26.
//

import Foundation

protocol DemoInterface {
    func fetchChallenges() async throws -> ChallengeEntity
    func advance() async throws -> ChallengeEntity
    func toggleRoutine(routineID: Int) async throws -> RoutineEntity
}

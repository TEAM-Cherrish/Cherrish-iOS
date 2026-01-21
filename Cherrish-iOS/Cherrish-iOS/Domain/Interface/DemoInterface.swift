//
//  DemoInterface.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/21/26.
//

import Foundation

protocol DemoInterface {
    func fetchChallenges() async throws -> ProgressChallengeEntity
    func advance() async throws -> ProgressChallengeEntity
    func toggleRoutine(routineID: Int) async throws -> ProgressRoutineEntity
    func createChallenge(missionIds: Int, routineNames: [String]) async throws
}

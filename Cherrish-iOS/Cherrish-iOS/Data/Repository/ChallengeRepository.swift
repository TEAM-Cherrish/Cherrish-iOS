//
//  ChallengeRepository.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/19/26.
//

import Foundation

import Alamofire

struct DefaultChallengeRepository: ChallengeInterface {
    private let networkService: NetworkService
    private let userDefaultService: UserDefaultService

    init(networkService: NetworkService, userDefaultService: UserDefaultService) {
        self.networkService = networkService
        self.userDefaultService = userDefaultService
    }

    func fetchHomecareRoutines() async throws -> [RoutineEntity] {
        let response = try await networkService.request(ChallengeAPI.fetchRoutines, decodingType: [ChallengeRoutineRequestDTO].self)

        return response.map { $0.toEntity() }
    }

    func aiRecommendations(id: Int) async throws -> [ChallengeMissionEntity] {
        let response = try await
        networkService.request(ChallengeAPI.aiRecommendations(homecareRoutineId: id),
                               decodingType: RecommendMissionsResponseDTO.self)
        CherrishLogger.debug(response)
        return response.toEntities()
    }

    func createChallenge(missionIds: Int, routineNames: [String]) async throws  {
        let userID: Int = userDefaultService.load(key: .userID) ?? 1
        let response: () = try await networkService.request(
            ChallengeDemoAPI.createChallenge(userID: userID, requestDTO:
                    .init(
                        homecareRoutineId: missionIds,
                        routineNames: routineNames
                    )
            )
        )
    }
}

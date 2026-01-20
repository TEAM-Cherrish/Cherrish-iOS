//
//  ChallengeRepository.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/19/26.
//

import Foundation

import Alamofire

struct ChallengeRepository: ChallengeInterface {

    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchHomecareRoutines() async throws -> [RoutineEntity] {
        let response = try await networkService.request(ChallengeAPI.fetchRoutines, decodingType: [ChallengeRoutineDTO].self)
        
        return response.map { $0.toEntity() }
    }
    
    func aiRecommendations(id: Int) async throws -> [ChallengeMissionEntity] {
        let response = try await networkService.request(ChallengeAPI.aiRecommendations(homecareRoutineId: id), decodingType: RecommentMisssionsResponseDTO.self)
        return response.routines
            .map { RecommendMissionsDTO(title: $0) }
            .map { $0.toEntity() }

    }
}

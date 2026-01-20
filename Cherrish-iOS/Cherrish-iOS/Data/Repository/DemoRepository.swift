//
//  DemoRepository.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/21/26.
//

import Foundation

struct DefaultDemoRepository: DemoInterface {
    private let networkService: NetworkService
    private let userDefaultService: UserDefaultService
    
    init(
        networkService: NetworkService,
        userDefaultService: UserDefaultService
    ) {
        self.networkService = networkService
        self.userDefaultService = userDefaultService
    }
    
    func fetchChallenges() async throws -> ChallengeEntity {
        let userID: Int = userDefaultService.load(key: .userID) ?? 1
        let response = try await networkService.request(
            DemoAPI.fetchChallenges(userID: userID),
            decodingType: FetchChallengesResponseDTO.self
        )
        
        return response.toEntity()
    }
    
    
}

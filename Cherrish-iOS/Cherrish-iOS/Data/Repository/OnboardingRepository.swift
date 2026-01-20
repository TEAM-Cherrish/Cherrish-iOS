//
//  OnboardingRepository.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/18/26.
//

import Foundation

struct DefaultOnboardingRepository: OnboardingInterface {
    private let networkService: NetworkService
    private let userDefaultService: UserDefaultService
    
    init(networkService: NetworkService, userDefaultService: UserDefaultService) {
        self.networkService = networkService
        self.userDefaultService = userDefaultService
    }
    
    func createProfile(name: String, age: Int) async throws -> ProfileEntity {
        let request = CreateProfileRequestDTO(name: name, age: age)
        let response = try await networkService.request(
            OnboardingAPI.createProfile(request: request),
            decodingType: CreateProfileResponseDTO.self
        )
        let profile = ProfileEntity(id: response.id, name: response.name)
        _ = userDefaultService.save(profile.id, key: .userID)
        _ = userDefaultService.save(true, key: .isOnboardingCompleted)
        return profile
    }
}

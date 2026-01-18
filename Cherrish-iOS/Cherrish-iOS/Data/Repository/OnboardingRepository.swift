//
//  OnboardingRepository.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/18/26.
//

import Foundation

struct DefaultOnboardingRepository: OnboardingInterface {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func createProfile(name: String, age: Int) async throws -> ProfileEntity {
        let request = CreateProfileRequestDTO(name: name, age: age)
        let response = try await networkService.request(
            OnboardingEndPoint.createProfile(request: request),
            decodingType: CreateProfileResponseDTO.self
        )
        return response.toEntity()
    }
}

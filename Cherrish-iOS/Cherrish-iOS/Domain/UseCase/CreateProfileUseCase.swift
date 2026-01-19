//
//  CreateProfileUseCase.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/18/26.
//

import Foundation

protocol CreateProfileUseCase {
    func execute(name: String, age: Int) async throws -> ProfileEntity
}

struct DefaultCreateProfileUseCase: CreateProfileUseCase {
    private let repository: OnboardingInterface
    
    init(repository: OnboardingInterface) {
        self.repository = repository
    }
    
    func execute(name: String, age: Int) async throws -> ProfileEntity {
        return try await repository.createProfile(name: name, age: age)
    }
}

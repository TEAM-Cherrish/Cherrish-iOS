//
//  OnboardingViewModel.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/8/26.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published var isOnboardingCompleted: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let createProfileUseCase: CreateProfileUseCase
    
    init(createProfileUseCase: CreateProfileUseCase) {
        self.createProfileUseCase = createProfileUseCase
    }
    
    @MainActor
    func createProfile(name: String, age: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            _ = try await createProfileUseCase.execute(name: name, age: age)
            isOnboardingCompleted = true
        } catch let error as CherrishError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "알 수 없는 오류가 발생했습니다."
        }
        
        isLoading = false
    }
    
    func completeOnboarding() {
        isOnboardingCompleted = true
    }
}

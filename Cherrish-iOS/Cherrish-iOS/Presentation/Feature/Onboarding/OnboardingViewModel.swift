//
//  OnboardingViewModel.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/8/26.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published var isOnboardingCompleted: Bool = false
    
    func completeOnboarding() {
        isOnboardingCompleted = true
    }
}

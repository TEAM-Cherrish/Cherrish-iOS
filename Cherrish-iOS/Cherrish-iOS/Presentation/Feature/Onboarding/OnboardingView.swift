//
//  OnboardingView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/8/26.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel:  OnboardingViewModel
    @EnvironmentObject private var onboardingCoordinator: OnboardingCoordinator
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        Button("Onboarding") {
            appCoordinator.navigationToTabbar()
        }
    }
}


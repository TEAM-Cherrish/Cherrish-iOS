//
//  AppCoordinatorView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/8/26.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var appCoordinator = AppCoordinator()
    @StateObject private var onboardingCoordinator = OnboardingCoordinator()
    
    var body: some View {
        switch appCoordinator.appState {
        case .onboarding:
            OnboardingCoordinatorView(onboardingCoordinator: onboardingCoordinator)
                .environmentObject(appCoordinator)
        case .home:
            ViewFactory.shared.makeHomeView()
                .environmentObject(appCoordinator)
        }
    }
}

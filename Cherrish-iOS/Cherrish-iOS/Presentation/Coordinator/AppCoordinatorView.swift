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
    @StateObject private var tabBarCoordinator = TabBarCoordinator()
    
    var body: some View {
        Group {
            switch appCoordinator.appState {
            case .onboarding:
                OnboardingCoordinatorView()
                    .environmentObject(onboardingCoordinator)
            case .home:
                TabBarCoordinatorView()
                    .environmentObject(tabBarCoordinator)
                
            }
        }
        .environmentObject(appCoordinator)
    }
}

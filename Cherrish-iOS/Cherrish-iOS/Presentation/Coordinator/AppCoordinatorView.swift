//
//  AppCoordinatorView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/8/26.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some View {
        Group {
            switch appCoordinator.appState {
            case .splash:
                SplashView()
                    .transition(.opacity)
                    .animation(.easeOut(duration: 0.7).delay(0.2), value: appCoordinator.appState)
            case .onboarding:
                OnboardingCoordinatorView()
            case .home:
                TabBarCoordinatorView()
                
            }
        }
        .environmentObject(appCoordinator)
    }
}

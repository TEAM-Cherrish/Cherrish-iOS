//
//  OnboardingCoordinatorView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/8/26.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject var onboardingCoordinator: OnboardingCoordinator
        
    var body: some View {
        NavigationStack(path: $onboardingCoordinator.path) {
            ViewFactory.shared.makeInformationView()
                .navigationDestination(for: OnboardingRoute.self) { route  in
                    switch route {
                    case .information:
                        ViewFactory.shared.makeInformationView()
                    case .onboarding:
                        ViewFactory.shared.makeOnboardingView()
                    }
                }
        }
    }
}

//
//  OnboardingCoordinatorView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/8/26.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var onboardingCoordinator = OnboardingCoordinator()
        
    var body: some View {
        NavigationStack(path: $onboardingCoordinator.path) {
            ViewFactory.shared.makeOnboardingContainerView()
                .navigationDestination(for: OnboardingRoute.self) { route  in
                    Group {
                        switch route {
                        case .onboarding:
                            ViewFactory.shared.makeOnboardingContainerView()
                        case .information:
                            ViewFactory.shared.makeInformationView()
                        }
                    }
                    .navigationBarBackButtonHidden()
                }
        }.environmentObject(onboardingCoordinator)
    }
}

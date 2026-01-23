//
//  SplashView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/17/26.
//

import SwiftUI

import Lottie

struct SplashView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    private let userDefaultService = DefaultUserDefaultService()
    
    var body: some View {
        ZStack(alignment: .center) {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .splashGradient1, location: 0.6),
                    .init(color: .splashGradient2, location: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            LottieView(animationName: "splash", loopMode: .playOnce)
                .frame(width: 130.adjustedW, height: 154.adjustedH)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if userDefaultService.load(key: .isOnboardingCompleted) ?? false {
                    appCoordinator.navigationToTabbar()
                } else {
                    appCoordinator.navigationToOnboarding()
                }
            }
        }
        .ignoresSafeArea()
    }
}

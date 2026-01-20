//
//  SplashView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/17/26.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
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
            
            Image(.appicon)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                let userID = UserDefaults.standard.integer(forKey: UserDefaultsKey.userID.rawValue)
                if userID != 0 {
                    appCoordinator.navigationToTabbar()
                } else {
                    appCoordinator.navigationToOnboarding()
                }
            }
        }
        .ignoresSafeArea()
    }
}

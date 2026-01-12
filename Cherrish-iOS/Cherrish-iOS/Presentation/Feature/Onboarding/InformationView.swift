//
//  InformationView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/8/26.
//

import SwiftUI

struct InformationView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @EnvironmentObject private var onboardingCoordinator: OnboardingCoordinator
    
    var body: some View {
        Button("InformationView") {
            onboardingCoordinator.push(.onboarding)
        }
    }
}

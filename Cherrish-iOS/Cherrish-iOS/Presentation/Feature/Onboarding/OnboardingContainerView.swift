//
//  OnboardingContainerView.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/15/26.
//

import SwiftUI

struct OnboardingContainerView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @EnvironmentObject private var onboardingCoordinator: OnboardingCoordinator
    
    @State private var currentPage = 0
    @State private var buttonState: ButtonState = .active
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                TabView(selection: $currentPage) {
                    OnboardingPage1()
                        .tag(0)
                        .padding(.horizontal, 25.adjustedW)

                    OnboardingPage2()
                        .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                
                Spacer()
                    .frame(height: 40.adjustedH)
                
                PageIndicator(currentPage: currentPage, totalPages: 2)
                
                CherrishButton(
                    title: "시작하기",
                    type: .large,
                    state: $buttonState,
                    leadingIcon: nil,
                    trailingIcon: nil
                ) {
                    onboardingCoordinator.push(.information)
                }
                .padding(.top, 21.adjustedH)
                .padding(.horizontal, 25.adjustedW)
                .opacity(currentPage == 1 ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: currentPage)
                
                Spacer()
            }
            
            Image(.close)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 24.adjustedW, height: 24.adjustedW)
                .foregroundStyle(.gray600)
                .padding(.trailing, 29.adjustedW)
                .padding(.top, 74.adjustedH)
                .onTapGesture {
                    onboardingCoordinator.push(.information)
                }
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(
            VStack(spacing: 0) {
                LinearGradient(
                    colors: [.homeGradient1Onboarding, .homeGradient2],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 310.adjustedH)
                
                Color.homeGradient2
            }
            .ignoresSafeArea()
        )
    }
}

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
                    OnboardingPage2()
                        .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                PageIndicator(currentPage: currentPage, totalPages: 2)
                    .padding(.top, 46.adjustedH)
                    .padding(.bottom, 22.adjustedH)
                
                CherrishButton(
                    title: "시작하기",
                    type: .confirm,
                    state: $buttonState
                ) {
                    onboardingCoordinator.push(.information)
                }
                .padding(.horizontal, 25.adjustedW)
                .padding(.bottom, 57.adjustedH)
                .opacity(currentPage == 1 ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: currentPage)
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
                    colors: [Color("home_gradient1"), Color("home_gradient2")],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 310)
                
                Color("home_gradient2")
            }
            .ignoresSafeArea()
        )
    }
}

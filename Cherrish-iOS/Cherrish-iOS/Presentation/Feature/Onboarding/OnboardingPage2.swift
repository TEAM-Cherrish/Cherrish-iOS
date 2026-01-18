//
//  OnboardingPage2.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/15/26.
//

import SwiftUI

struct OnboardingPage2: View {
    @EnvironmentObject private var onboardingCoordinator: OnboardingCoordinator
    
    @State private var offsetX: CGFloat = 0
    
    private let levelImages: [ImageResource] = [.LV_0, .LV_1, .LV_2, .LV_3, .LV_4]
    
    private let animationDuration: Double = 10.0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                
                Image(.close)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24.adjustedW, height: 24.adjustedW)
                    .foregroundStyle(.gray600)
                    .onTapGesture {
                        onboardingCoordinator.push(.information)
                    }
            }
            .padding(.horizontal, 29.adjustedW)
            .padding(.top, 30.adjustedH)
            
            
            
            HStack(spacing: 0) {
                TypographyText("원하는 추구미에 도달할 수 있도록\nTO-DO 루틴을 제시해줘요", style: .title1_m_18, color: .gray1000)
            
                Spacer()
            }
            .padding(.horizontal, 42.adjustedW)
            .padding(.top, 50.adjustedH)
            
            Image(.onboarding2)
                .resizable()
                .scaledToFit()
                .padding(.top, 40.adjustedH)
                .padding(.horizontal, 41.adjustedW)
                        
            InfiniteLevelCarousel(levelImages: levelImages, animationDuration: animationDuration)
                .frame(height: 89.adjustedH)
                .padding(.top, 20.adjustedH)

            TypographyText("TO-DO 미션을 채울때마다 아리가 변화해요!", style: .title2_r_16, color: .gray600)
                .padding(.top, 30.adjustedH)
            
            Spacer()
        }
    }
}

struct InfiniteLevelCarousel: View {
    let levelImages: [ImageResource]
    let animationDuration: Double
    
    private var imageSize: CGFloat { 89.adjustedW }
    
    @State private var offsetX: CGFloat = 0
    @State private var singleSetWidth: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var animationID: UUID = UUID()
    @State private var screenWidth: CGFloat = 0
    
    private var initialOffset: CGFloat {
        return -(singleSetWidth - (screenWidth - singleSetWidth) / 2)
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(0..<3, id: \.self) { _ in
                    HStack(spacing: 0) {
                        ForEach(levelImages.indices, id: \.self) { index in
                            Image(levelImages[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: imageSize, height: imageSize)
                        }
                    }
                }
            }
            .offset(x: offsetX)
            .onAppear {
                screenWidth = geometry.size.width
                singleSetWidth = imageSize * CGFloat(levelImages.count)
                startAnimation()
            }
            .onDisappear {
                stopAnimation()
            }
        }
        .clipped()
    }
    
    private func startAnimation() {
        guard !isAnimating else { return }
        
        isAnimating = true
        let currentAnimationID = UUID()
        animationID = currentAnimationID
        
        offsetX = initialOffset
        animateCarousel(animationID: currentAnimationID)
    }
     
    private func stopAnimation() {
        isAnimating = false
        animationID = UUID()
        
        offsetX = initialOffset
    }
    
    private func animateCarousel(animationID: UUID) {
        guard self.animationID == animationID, isAnimating else { return }
        
        withAnimation(.linear(duration: animationDuration)) {
            offsetX = initialOffset - singleSetWidth
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {

            guard self.animationID == animationID, isAnimating else { return }
            
            offsetX = initialOffset

            animateCarousel(animationID: animationID)
        }
    }
}

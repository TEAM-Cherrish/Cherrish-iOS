//
//  OnboardingPage1.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/15/26.
//

import SwiftUI

struct OnboardingPage1: View {
    @EnvironmentObject private var onboardingCoordinator: OnboardingCoordinator
    
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
            
            Image(.illustrationOnboardingCal)
                .resizable()
                .scaledToFit()
                .frame(width: 294.adjustedW)
                .overlay(alignment: .topLeading) {
                    Image(.illustrationOnboardingCh)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120.adjustedW)
                        .alignmentGuide(.leading) { _ in -152.adjustedW }
                        .alignmentGuide(.top) { _ in -209.adjustedH }
                }
                .padding(.top, 38.adjustedH)
            
            HStack(spacing: 0) {
                Image(.comment)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100.adjustedW)
                    .padding(.top, 120.adjustedH)
                    .padding(.leading, 30.adjustedW)
                
                Spacer()
            }
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    TypographyText("시술 후 불편감이 남을 수 있는 기간을 계산해", style: .title1_sb_18, color: .gray1000)
                    
                    Rectangle()
                        .fill(Color.red700)
                        .frame(width: 252.adjustedW, height: 1.4)
                    Rectangle()
                        .fill(Color.red700)	
                        .frame(width: 260.adjustedW, height: 1.4) 
                        .padding(.top, 3)
                    
                    TypographyText("일정을 한 눈에 정리해드려요", style: .title1_sb_18, color: .gray1000)
                        .padding(.top, 6.adjustedH)
                }
                .padding(.top, 7.adjustedH)
                .frame(maxWidth: .infinity)
                Spacer()
            }
            
            
            Spacer()
        }
    }
}

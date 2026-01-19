//
//  OnboardingPage1.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/15/26.
//

import SwiftUI

struct OnboardingPage1: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(.illustrationOnboardingCal)
                .resizable()
                .scaledToFit()
                .frame(width: 294.adjustedW)
                .overlay(alignment: .topLeading) {
                    Image(.illustrationOnboardingCh)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120.adjustedW)
                        .offset(x: 152.adjustedW, y: 180.adjustedH)
                }
                .padding(.top, 92.adjustedH)
            
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
                        .padding(.leading, 4)
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

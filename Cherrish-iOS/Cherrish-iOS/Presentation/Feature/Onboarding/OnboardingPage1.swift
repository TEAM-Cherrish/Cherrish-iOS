//
//  OnboardingPage1.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/15/26.
//

import SwiftUI

struct OnboardingPage1: View {
    @State private var line1Width: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Image(.illustrationOnboardingCal)
                .resizable()
                .scaledToFit()
                .frame(width: 294.adjustedW, height: 254.adjustedH)
                .overlay(alignment: .topLeading) {
                    Image(.illustrationOnboardingCh)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 152.adjustedW, height: 204.adjustedH)
                        .offset(x: 152.adjustedW, y: 209.adjustedH)
                }
                .padding(.top, 102.adjustedH)
            
            HStack(spacing: 0) {
                Image(.comment)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100.adjustedW, height: 44.adjustedH)
                    .padding(.top, 120.adjustedH)
                    .padding(.leading, 30.adjustedW)
                
                Spacer()
            }
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    TypographyText("시술 후 불편감이 남을 수 있는 기간을 계산해", style: .title1_sb_18, color: .gray1000)
                    
                    Rectangle()
                        .fill(Color.red700)
                        .frame(width: line1Width, height: 1.4)
                        .padding(.leading, 4.adjustedW)
                    Rectangle()
                        .fill(Color.red700)
                        .frame(width: line1Width + 8, height: 1.4)
                        .padding(.top, 3.adjustedH)
                    
                    TypographyText("일정을 한 눈에 정리해드려요", style: .title1_sb_18, color: .gray1000)
                        .padding(.top, 6.adjustedH)
                }
                .frame(maxWidth: .infinity)
                .background(
                    VStack(alignment: .leading, spacing: 0) {
                        TypographyText("시술 후 불편감이 남을 수 있는 기간", style: .title1_sb_18, color: .clear)
                            .background(
                                GeometryReader { geometry in
                                    Color.clear.preference(key: Line1WidthKey.self, value: geometry.size.width)
                                }
                            )
                    }
                    .opacity(0)
                )
                .onPreferenceChange(Line1WidthKey.self) { width in
                    line1Width = width
                }
                Spacer()
            }
            .padding(.top, 7.adjustedH)
            
            
            Spacer()
        }
    }
}

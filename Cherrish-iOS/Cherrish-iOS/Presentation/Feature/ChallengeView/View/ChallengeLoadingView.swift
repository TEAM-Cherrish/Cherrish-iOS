//
// LoadingView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/10/26.
//

import SwiftUI

import Lottie

struct ChallengeLoadingView: View {
    @ObservedObject var viewModel: CreateChallengeViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
                .frame(height: 94.adjustedH)
            
            VStack(spacing: 2) {
                highlight(highlightText: viewModel.selectedRoutine?.description ?? "", normalText: "방향을 바탕으로")
                    .frame(height: 27.adjustedH)
                TypographyText("TO-DO 미션을 만들고 있어요.", style: .title1_sb_18, color: .gray800)
                    .frame(height: 27.adjustedH)
            }
            
            Spacer()
                .frame(height: 80.adjustedH)
            
            LottieView(animationName: "splash", loopMode: .loop)
                .frame(width: 130.adjustedW, height: 154.adjustedH)
            
            Spacer()
                .frame(height: 80.adjustedH)
            
            TypographyText("잠시만 기다려주세요!", style: .title2_m_16, color: .gray800)
                .frame(height: 24.adjustedH)
                .padding(.top, 17.adjustedH)
            
            Spacer()
            
            TypographyText("AI가 맞춤형 루틴을 제작하고 있어요.", style: .body3_m_12, color: .gray600)
                .frame(height: 17.adjustedH)
                .padding(.bottom, 30.adjustedH)
            
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(edges: .bottom)
    }
}

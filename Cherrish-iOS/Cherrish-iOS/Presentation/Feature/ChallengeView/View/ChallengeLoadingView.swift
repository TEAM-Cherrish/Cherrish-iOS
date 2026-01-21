//
// LoadingView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/10/26.
//

import SwiftUI

struct ChallengeLoadingView: View {
    @ObservedObject var viewModel: CreateChallengeViewModel   
    
    var body: some View {
        VStack {
            VStack(spacing: 4.adjustedH) {
               highlight(highlightText: viewModel.selectedRoutine?.description ?? "", normalText: "관리 방향을 바탕으로")
                   .padding(.top, 113.adjustedH)
               TypographyText("TO-DO 미션을 만들고 있어요.", style: .title1_sb_18, color: .gray800)
                Image(.loading)
                    .padding(.top, 17.adjustedH)
                TypographyText("잠시만 기다려주세요!", style: .title2_sb_16, color: .gray800)
                    .padding(.top, 17.adjustedH)
                Spacer()
                TypographyText("AI가 맞춤형 루틴을 제작하고 있어요.", style: .body3_m_12, color: .gray600)
                    .padding(.bottom, 30.adjustedH)
           }
       }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(edges: .bottom)
   }
}

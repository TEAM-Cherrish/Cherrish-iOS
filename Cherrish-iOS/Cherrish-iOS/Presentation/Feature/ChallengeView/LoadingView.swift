//
// LoadingView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/10/26.
//

import SwiftUI

struct LoadingView: View {
   @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
   
    var body: some View {
        VStack {
           CherrishNavigationBar(
            isDisplayRightButton:false,
            leftButtonAction: challengeCoordinator.pop
           )
            VStack(spacing: 4.adjustedH) {
               highlight(highlightText: "피부 컨디션", normalText: "관리 방향을 바탕으로")
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
//        .padding(.top, 20.adjustedH)
        .onAppear {
            moveNextAfterDelay()
        }
   }
    
    private func moveNextAfterDelay() {
        Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            await MainActor.run {
                challengeCoordinator.push(.selectMission)
            }
        }
    }
}

//
//  StartChallengeView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/10/26.
//

import SwiftUI

struct StartChallengeView: View {
    @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
    
    @State private var startButtonState: ButtonState = .active
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    TypographyText("이번엔 어떤 루틴으로 관리할까요?", style: .headline_sb_20, color: .gray1000)
                    TypographyText("루틴을 지킬수록 체리가 성장해요.", style: .title2_m_16, color: .gray800)
                }
                Spacer()
            }
            .padding(.top, 84.adjustedH)
            .padding(.leading, 24.adjustedW)
            
            Spacer()
            
            Image(.challengeStartCherry)
            
            Spacer()
            
            HStack(spacing: 12) {
                Image("info")
                TypographyText("이 챌린지는 설정 시점부터 7일간 진행됩니다.", style: .body3_m_12, color: .gray600)
            }
            .padding(.bottom, 12.adjustedH)
            
            CherrishButton(title: "챌린지 시작하기", type: .next, state: $startButtonState) {
                challengeCoordinator.push(.selectRoutine)
            }
            .padding(.horizontal, 24.adjustedW)
            .padding(.bottom, 36.adjustedH)
        }
    }
}

//
//  StartChallengeView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/10/26.
//

import SwiftUI

struct ChallengeStartChallengeView: View {
    @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
    @EnvironmentObject private var tabBarCoordinator: TabBarCoordinator
    
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
            .padding(.bottom, 34.adjustedH)
            
            Image(.illustrationChallengeStart)
                .padding(.top, 10.adjustedH)
                .padding(.horizontal, 24.adjustedW)
            
            HStack(spacing: 0) {
                Image("info")
                TypographyText("이 챌린지는 설정 시점부터 7일간 진행됩니다.", style: .body3_m_12, color: .gray600)
            }
            .padding(.top, 20.adjustedH)
            
            CherrishButton(
                title: "챌린지 시작하기",
                type: .large,
                state: $startButtonState,
                leadingIcon: nil,
                trailingIcon: nil
            ) {
                challengeCoordinator.push(.createChallenge)
                tabBarCoordinator.isTabbarHidden = true
            }
            .padding(.horizontal, 24.adjustedW)
            .padding(.bottom, 36.adjustedH)
        }
    }
}

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
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 4){
                    Text("이번엔 어떤 루틴으로 관리할까요?")
                        .typography(.headline_sb_20)
                        .foregroundStyle(.gray1000)
                    Text("루틴을 지킬수록 체리가 성장해요.")
                        .typography(.title2_m_16)
                        .foregroundStyle(.gray800)
                }
                Spacer()
            }
            .padding(.top, 84)
            .padding(.leading, 24)
            
            Spacer()
            
            Image("challengeStartCherry")
            
            Spacer()
            
            HStack(spacing: 12){
                Image("info")
                Text("이 챌린지는 설정 시점부터 7일간 진행됩니다.")
                    .typography(.body3_m_12)
                    .foregroundStyle(.gray600)
            }
            .padding(.bottom, 12)
            
            CherrishButton(title: "챌린지 시작하기", type: .next, state: $startButtonState) {
                challengeCoordinator.push(.selectRoutine)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 36)
        }
    }
}

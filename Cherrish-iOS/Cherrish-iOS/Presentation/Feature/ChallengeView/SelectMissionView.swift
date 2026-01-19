//
//SelectMissionView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/10/26.
//

import SwiftUI

struct SelectMissionView: View {
    
    @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
    
    @State private var missions: [String] = [
        "진정 토너 + 세럼",
        "진정 토너 + 세럼",
        "진정 토너 + 세럼",
        "선크림 3번 바르기",
        "선크림 3번 바르기",
        "선크림 3번 바르기"
    ]
    @State private var selectedStates: [Bool] = Array(repeating: false, count: 6)
    
    private var nextButtonState: ButtonState {
        selectedStates.contains(true) ? .active : .normal
    }
    
    var body: some View {
        VStack {
            CherrishNavigationBar(
                title: "TO-DO 미션 선택",
                leftButtonAction: challengeCoordinator.pop,
                rightButtonAction: challengeCoordinator.popToRoot
            )
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        TypographyText("챌린지 기간 동안",
                            style: .title1_sb_18,
                            color: .gray1000
                        )
                        TypographyText("진행할 미션을 선택해주세요.",
                            style: .title1_sb_18,
                            color: .gray1000
                        )
                        TypographyText("복수 선택이 가능해요.",
                            style: .body1_r_14,
                            color: .gray700
                        )
                        .padding(.top, 4.adjustedH)
                    }
                    Spacer()
                }
                .padding(.bottom, 30.adjustedH)
                VStack(spacing: 10.adjustedH) {
                    ForEach(missions.indices, id: \.self) { index in
                        MissionCard(
                            missionText: missions[index],
                            isSelected: $selectedStates[index]
                        )
                    }
                }
            }
            .padding(.horizontal, 34.adjustedW)
            .padding(.top, 48.adjustedH)
            Spacer()
            CherrishButton(title: "플래너에 추가하기", type: .next, state: .constant(nextButtonState)){
                challengeCoordinator.push(.challengeProgress)
            }
            .padding(.horizontal, 24.adjustedW)
            .padding(.bottom, 38.adjustedH)
        }
        .frame(maxHeight: .infinity)
        .onAppear {
            selectedStates = Array(repeating: false, count: missions.count)
        }
        .onChange(of: missions) { newMissions in
            selectedStates = Array(repeating: false, count: newMissions.count)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

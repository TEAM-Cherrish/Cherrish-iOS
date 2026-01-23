//
//SelectMissionView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/10/26.
//

import SwiftUI

struct ChallengeSelectMissionView: View {

    @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
    @ObservedObject var viewModel: CreateChallengeViewModel

    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        TypographyText("챌린지 기간 동안\n진행할 미션을 선택해주세요.",
                                       style: .title1_sb_18,
                                       color: .gray1000
                        )
                        .frame(height: 54.adjustedH)
                        TypographyText("복수 선택이 가능해요.",
                                       style: .body1_r_14,
                                       color: .gray700
                        )
                        .frame(height: 20.adjustedH)
                        .padding(.top, 4.adjustedH)
                    }
                    Spacer()
                }
                .padding(.bottom, 30.adjustedH)
                VStack(spacing: 10.adjustedH) {
                    ForEach(viewModel.missions) { mission in
                        MissionCard(
                            missionText: mission.title,

                            isSelected: Binding(
                                get: {
                                    viewModel.missionsSelectedState[mission] ?? false
                                },
                                set: { newValue in
                                    viewModel.missionsSelectedState[mission] = newValue
                                }
                            )
                        )
                    }
                }
            }
            .padding(.horizontal, 34.adjustedW)
            .padding(.top, 48.adjustedH)
            Spacer()

            CherrishButton(
                title: "플래너에 추가하기",
                type: .large,
                state: $viewModel.nextButtonState,
                leadingIcon: nil,
                trailingIcon: nil
            )
            {
                Task {
                    do {
                        try await viewModel.makeChallenge()
                        challengeCoordinator.push(.challengeProgress)
                    } catch {
                        CherrishLogger.error(error)
                    }
                }
            }
            .padding(.horizontal, 24.adjustedW)
            .padding(.bottom, 38.adjustedH)
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(edges: .bottom)
    }
}

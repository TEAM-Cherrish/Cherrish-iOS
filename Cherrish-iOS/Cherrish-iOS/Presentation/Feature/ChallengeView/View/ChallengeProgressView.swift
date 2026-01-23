//
//  ChallengeProgressView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/14/26.
//

import SwiftUI

struct ChallengeProgressView: View {
    @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
    @StateObject var viewModel: ChallengeProgressViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                CherrishLoadingView()
            }
            else {
                ChallengeProgressContentView(viewModel: viewModel)
            }
        }
        .task {
            await viewModel.loadChallenge()
        }
    }
}


private struct ChallengeProgressContentView: View {
    @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
    @StateObject var viewModel: ChallengeProgressViewModel
    
    let buttonState: ButtonState = .active
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    TypographyText(viewModel.challengeTitle, style: .title1_sb_18, color: .gray1000)
                        .frame(height: 27.adjustedH)
                        .padding(.trailing, 12.adjustedW)
                    TypographyText("7일 플랜", style: .body3_m_12, color: .gray700)
                        .frame(height: 17.adjustedH)
                        .padding(.horizontal, 8.adjustedW)
                        .padding(.vertical, 3.adjustedH)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(.gray700, lineWidth: 1)
                        )
                    Spacer()
                }
                CherryGrowthView
                CherryTodoView
            }
            .padding(.horizontal, 25.adjustedW)
            .padding(.vertical, 24.adjustedH)
        }
        .scrollIndicators(.hidden)
    }
}
extension ChallengeProgressContentView {
    private var CherryGrowthView: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    TypographyText("Lv.\(viewModel.cherryLevel.levelNumber)", style: .body1_m_14, color: .gray900)
                        .frame(height: 20.adjustedH)
                    TypographyText("\(viewModel.cherryLevel.name)", style: .body1_m_14, color: .gray900)
                        .frame(height: 20.adjustedH)
                        .padding(.leading, 6.adjustedW)
                    Spacer()
                }
                viewModel.cherryLevel.cherryImage
                    .frame(width: 154.adjustedW, height: 154.adjustedW)
                    .padding(.bottom, 5.adjustedH)
                if viewModel.cherryLevel.levelNumber == 4 {
                    TypographyText("챌린지 완료까지 \(viewModel.remainMissions)개의 미션을 수행해야 해요!", style: .body2_r_13, color: .gray800)
                        .frame(height: 18.adjustedH)
                        .padding(.bottom, 14.adjustedH)
                }else {
                    TypographyText("체리가 크려면 \(viewModel.remainMissions)개의 미션을 수행해야 해요!", style: .body2_r_13, color: .gray800)
                        .frame(height: 18.adjustedH)
                        .padding(.bottom, 14.adjustedH)
                }
            }
            .padding(.horizontal, 25.adjustedW)
            Rectangle()
                .fill(.gray300)
                .frame(height: 1)
                .padding(.bottom, 14.adjustedH)
            VStack {
                HStack {
                    TypographyText("챌린지 달성률 \(viewModel.progressRate)%", style: .body1_m_14, color: .gray900)
                        .frame(height: 20.adjustedH)
                    Spacer()
                }
                .padding(.bottom, 12.adjustedH)
                viewModel.cherryLevel.progressImage
                    .padding(.bottom, 11.adjustedH)
            }
            .padding(.horizontal, 25.adjustedW)
        }
        .padding(.top, 16.adjustedH)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.red200, .gray0]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        )
        .cherrishShadow()
    }
    
    private var CherryTodoView: some View {
        VStack {
            HStack {
                TypographyText("\(viewModel.currentDay)일차 TO-DO 미션", style: .body1_sb_14, color: .gray1000)
                    .frame(height: 20.adjustedH)
                Spacer()
            }
            Spacer()
            VStack(spacing: 8.adjustedH) {
                ForEach(viewModel.todayRoutines, id: \.routineID) { routine in
                    CheckBoxComponent(
                        text: routine.name,
                        isChecked: Binding(
                            get: { routine.isComplete },
                            set: { _ in
                                Task {
                                    await viewModel.toggleRoutine(routineID: routine.routineID)
                                }
                            }
                        )
                    )
                }
            }
            
            CherrishButton(
                title: viewModel.isChallengeCompleted ? "챌린지 종료하기":"오늘 미션 종료하기",
                type: .small,
                state: .constant(buttonState),
                leadingIcon: nil,
                trailingIcon: nil
            ) {
                if viewModel.isChallengeCompleted {
                    Task {
                        await viewModel.advanceDay()
                        challengeCoordinator.push(.startChallenge)
                    }
                }else {
                    Task {
                        await viewModel.advanceDay()
                    }
                }
            }
            .padding(.top, 10.adjustedH)
            .padding(.bottom, 18.adjustedH)
        }
        .padding(.top, 14.adjustedH)
        .padding(.horizontal, 18.adjustedW)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray0)
        )
        .cherrishShadow()
    }
}

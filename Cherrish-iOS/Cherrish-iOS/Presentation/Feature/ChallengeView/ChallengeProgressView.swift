//
//  ChallengeProgressView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/14/26.
//

import SwiftUI

struct ChallengeProgressView: View {
    
    @State private var isChecked = false
    
    private var progressRate: Double = 50.9
    private var cherryLevel: Int = 1
    private var cherryLevelName: String = "아기 체리"
    private var remainMissions: Int = 3
    
    @State private var missions: [String] = [
        "진정 토너 + 세럼",
        "진정 토너 + 세럼",
        "선크림 3번 바르기",
        "선크림 3번 바르기"
    ]
    
    private var progressBarImage: Image {
        switch progressRate {
        case 0.0..<25.0:
            return Image(.challengeGaugebar1)
        case 25.0..<50.0:
            return Image(.challengeGaugebar2)
        case 50.0..<75.0:
            return Image(.challengeGaugebar3)
        case 75.0...100.0:
            return Image(.challengeGaugebar4)
        default:
            return Image(.challengeGaugebar1)
        }
    }

    
    @State private var selectedStates: [Bool] = Array(repeating: false, count: 6)
    private var completeButtonState: ButtonState {
//        selectedStates.contains(true) ? .active : .normal
            .active
    }
    
    var body: some View {
        VStack{
            HStack {
                TypographyText("피부 컨디션 챌린지", style: .title1_sb_18, color: .gray1000)
                    .padding(.trailing, 12.adjustedW)
                TypographyText("7일 플랜", style: .body3_m_12, color: .gray700)
                    .padding(.horizontal, 8.adjustedW)
                    .padding(.vertical, 4.adjustedH)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.gray700, lineWidth: 1)
                    )
                Spacer()
            }
            
            ZStack(alignment: .topLeading) {
                VStack {
                    HStack {
                        TypographyText("Lv.\(cherryLevel) \(cherryLevelName)", style: .body1_m_14, color: .gray900)
                        Spacer()
                    }
                    Image(.challenge)
                        .padding(.top, 14.adjustedH)
                    TypographyText("체리가 크려면 \(remainMissions)개의 미션을 수행해야 해요!", style: .body2_r_13, color: .gray800)
                        .padding(.top, 14.adjustedH)
                    HStack {
                        TypographyText("챌린지 달성률 \(progressRate)%", style: .body1_m_14, color: .gray900)
                        Spacer()
                    }
                    .padding(.top, 28.adjustedH)
                    .padding(.bottom, 12.adjustedH)
                    
                    progressBarImage
                        .padding(.bottom, 11.adjustedH)
                }
                .padding(.top, 16.adjustedH)
                .padding(.horizontal, 25.adjustedW)
                .background(.gray0)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray0)
                )
                .cherrishShadow()
                
                Rectangle()
                    .fill(Color.gray300)
                    .frame(height: 1)
                    .padding(.top, 232.adjustedH)
            }
            
            VStack {
                HStack {
                    TypographyText("4일차 TODO 미션", style: .body1_sb_14, color: .gray1000)
                    Spacer()
                }
                
                Spacer()
                VStack(spacing: 8.adjustedH) {
                    ForEach(missions.indices, id: \.self) { index in
                        CheckBoxComponent(
                            text: missions[index],
                            isChecked: $selectedStates[index]
                        )
                        
                    }
                }
                
                CherrishButton(title: "오늘 미션 종료하기", type: .next, state: .constant(completeButtonState)){
                    
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
        .padding(.horizontal, 25.adjustedW)
        .padding(.vertical, 24.adjustedH)
    }
}

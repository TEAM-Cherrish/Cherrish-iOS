//
//  ChallengeProgressView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/14/26.
//

import SwiftUI

enum CherryLevel: Int {
    case mong = 1
    case bbo
    case pang
    case ggu
    
    var levelNumber: Int { rawValue }
    
    static func from(progressRate: Double) -> CherryLevel {
        switch progressRate {
        case 0.0..<25.0:
            return .mong
        case 25.0..<50.0:
            return .bbo
        case 50.0..<75.0:
            return .pang
        case 75.0...100.0:
            return .ggu
        default:
            return .mong
        }
    }
    
    var name: String {
        switch self {
        case .mong: return "몽롱체리"
        case .bbo: return "뽀득체리"
        case .pang: return "팡팡체리"
        case .ggu: return "꾸꾸체리"
        }
    }
    
    var cherryImage: Image {
        Image("cherry\(rawValue)")
    }
    var progressImage: Image {
        Image("challenge_gaugebar_\(levelNumber)")
    }
}

struct ChallengeProgressView: View {
    
    @State private var isChecked = false
    private var progressRate: Double = 100
    private var cherryLevel: CherryLevel {
        CherryLevel.from(progressRate: progressRate)
    }
    private var remainMissions: Int = 3
    
    @State private var missions: [String] = [
        "진정 토너 + 세럼",
        "진정 토너 + 세럼",
        "선크림 3번 바르기",
        "선크림 3번 바르기",
        "선크림 3번 바르기",
        "선크림 3번 바르기"
    ]
    
    @State private var selectedStates: [Bool] = Array(repeating: false, count: 6)
    
    let buttonState: ButtonState = .active
    
    var body: some View {
        ScrollView {
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
                CherryGrowthView
                CherryTodoView
            }
            .padding(.horizontal, 25.adjustedW)
            .padding(.vertical, 24.adjustedH)
        }
        .scrollIndicators(.hidden)
    }
}

extension ChallengeProgressView {
    private var CherryGrowthView : some View {
        VStack {
            VStack {
                HStack {
                    TypographyText("Lv.\(cherryLevel.levelNumber) \(cherryLevel.name)", style: .body1_m_14, color: .gray900)
                    Spacer()
                }
                cherryLevel.cherryImage
                    .padding(.top, 14.adjustedH)
                TypographyText("체리가 크려면 \(remainMissions)개의 미션을 수행해야 해요!", style: .body2_r_13, color: .gray800)
                    .padding(.top, 14.adjustedH)
            }
            .padding(.horizontal, 25.adjustedW)
            Rectangle()
                .fill(.gray300)
                .frame(height: 1)
                .padding(.vertical, 14.adjustedH)
            VStack {
                HStack {
                    TypographyText("챌린지 달성률 \(progressRate)%", style: .body1_m_14, color: .gray900)
                    Spacer()
                }
                .padding(.bottom, 12.adjustedH)
                cherryLevel.progressImage
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
}

extension ChallengeProgressView {
    private var CherryTodoView : some View {
        VStack {
            HStack {
                TypographyText("4일차 TO-DO 미션", style: .body1_sb_14, color: .gray1000)
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
            CherrishButton(title: "오늘 미션 종료하기", type: .next, state: .constant(buttonState)){
                
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

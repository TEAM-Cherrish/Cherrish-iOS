//
//  DowntimeBottomSheetView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/16/26.
//

import SwiftUI

struct DowntimeBottomSheetView: View {
    let treatment: TreatmentEntity
    let today: (year: Int, month: Int, day: Int)
    let setday: (year: Int, month: Int, day: Int)
    @State private var selectedDowntime: Int = 1
    @State private var rate: Double = 0.0
    @State private var betweenDays: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 35.adjustedH)
            
            TypographyText("개인 다운타임으로 설정해주세요.", style: .title1_sb_18, color: .gray1000)
                .frame(height: 27.adjustedH)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 25.adjustedH)
            
            Spacer()
                .frame(height: 44.adjustedH)
            
            speechBubble
            
            downtimeProgressBar
                .padding(.top, 8.adjustedH)
            
            Spacer()
                .frame(height: 25.adjustedH)
            
            grayLineView
                .padding(.horizontal, 25.adjustedW)
            
            pickerView
            
            grayLineView
                .padding(.horizontal, 25.adjustedW)
            
            Spacer()
                .frame(height: 44.adjustedH)
            buttonView
            
        }
        .onAppear {
            selectedDowntime = treatment.downtimeMax
            betweenDays = Int.daysBetween(
                fromYear: setday.year,
                fromMonth: setday.month,
                fromDay: setday.day,
                toYear: today.year,
                toMonth: today.month,
                toDay: today.day
            )
            rate = min(Double(selectedDowntime) / Double(betweenDays), 1.0)
        }
        .onChange(of: selectedDowntime) {
            rate = min(Double(selectedDowntime) / Double(betweenDays), 1.0)
        }
    }
}

extension DowntimeBottomSheetView {
    
    private var speechBubble: some View {
        ZStack {
            Image(.speechBubble)
                .resizable()
                .scaledToFill()
                .frame(height: 53.adjustedH)
            
            Group {
                if betweenDays - selectedDowntime < 1 {
                    TypographyText(
                        "설정한 다운타임은 목표일을 넘깁니다.",
                        style: .body1_r_14,
                        color: .gray1000
                    )
                } else {
                    TypographyText(
                        "회복 목표디데이로부터 약 \(betweenDays - selectedDowntime)일 전에 안정될 수 있어요.",
                        style: .body1_r_14,
                        color: .gray1000
                    )
                }
            }
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .padding(.horizontal, 18.adjustedW)
                .offset(y: -4.adjustedH)
            
        }
        .padding(.horizontal, 25.adjustedW)
        .frame(height: 53.adjustedH)
    }
    
    private var downtimeProgressBar: some View {
        VStack {
            HStack {
                Spacer()
                
                TypographyText("다운타임 \(selectedDowntime)일", style: .title2_m_16, color: .red600)
                
                Spacer ()
                
                TypographyText("여유기간 \(betweenDays - selectedDowntime < 0 ? 0 : betweenDays - selectedDowntime)일", style: .title2_m_16, color: .gray800)
                Spacer()
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.gray400)
                        .frame(height: 8.adjustedH)
                    
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.red600)
                        .frame(
                            width: geometry.size.width * rate,
                            height: 8.adjustedH
                        )
                        .animation(.easeOut(duration: 0.5), value: rate)
                }
            }
            .frame(height: 8.adjustedH)
            .padding(.horizontal, 25.adjustedW)
            
            HStack {
                TypographyText("\(today.month)월 \(today.day)일", style: .body2_r_13, color: .gray700)
                    .frame(height: 18.adjustedH)
                
                Spacer()
                
                TypographyText("\(setday.month)월 \(setday.day)일", style: .body2_r_13, color: .gray700)
                    .frame(height: 18.adjustedH)
            }
            .padding(.horizontal, 25.adjustedW)
        }
    }
    
    private var grayLineView: some View {
        Rectangle()
            .frame(height: 1.adjustedH)
            .foregroundColor(.gray400)
    }
    
    private var pickerView: some View {
        HStack {
            Spacer()
            
            VStack(spacing: 0) {
                TypographyText(
                    "다운타임",
                    style: .headline_sb_20,
                    color: .gray1000
                )
                    .frame(height: 30.adjustedH)
                
                TypographyText(
                    "보통 \(treatment.downtimeMin)-\(treatment.downtimeMax)일",
                    style: .title2_m_16,
                    color: .gray600
                )
                .frame(height: 24.adjustedH)
            }
            
            Spacer()
            
            CherrishPicker(selection: $selectedDowntime, range: 1...30)
            
            Spacer()
        }
    }
    
    private var buttonView: some View {
        GeometryReader { geo in
            HStack(spacing: 4.adjustedW) {
                CherrishButton(
                    title: "다운타임 없이 일정 추가",
                    type: .addEvent,
                    state: .constant(
                        .normal
                    ),
                    leadingIcon: .none,
                    trailingIcon: .none,
                    action: { })
                .frame(width: geo.size.width * 2/3 - 2)
                
                CherrishButton(
                    title: "확인",
                    type: .small,
                    state: .constant(
                        .normal
                    ),
                    leadingIcon: .none,
                    trailingIcon: .none,
                    action: { })
                .frame(
                    width: geo.size.width * 1/3 - 2
                )
                
            }
        }
        .frame(height: 50.adjustedH)
        .padding(.horizontal, 24.adjustedW)
    }
}

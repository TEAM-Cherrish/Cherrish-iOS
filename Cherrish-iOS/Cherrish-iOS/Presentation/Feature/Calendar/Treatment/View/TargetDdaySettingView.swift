//
//  TargetDdaySettingView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/15/26.
//

import SwiftUI

enum DdayState: CaseIterable {
    case no
    case yes
    var id: Self { self }
    
    var title: String {
        switch self {
        case .no:
            return "아직 없어요"
        case .yes:
            return "네, 있어요"
        }
    }
    
}

struct TargetDdaySettingView: View {
    @Binding var dDayState: DdayState?
    @Binding var year: String
    @Binding var month: String
    @Binding var day: String
    @Binding var warningMessage: String
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Spacer()
                        .frame(height: 50.adjustedH)
                    
                    HStack(spacing:0){
                        VStack(alignment: .leading, spacing: 0) {
                            TypographyText("회복을 계획할 때 고려해야 할", style: .title1_sb_18, color: .gray1000)
                                .frame(height: 27.adjustedH)
                            TypographyText("중요한 일정이 있나요?", style: .title1_sb_18, color: .gray1000)
                                .frame(height: 27.adjustedH)
                        }
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 40.adjustedH)
                    
                    HStack(spacing: 12.adjustedW) {
                        ForEach(DdayState.allCases, id: \.self) { state in
                            SelectionChip(
                                title: state.title,
                                isSelected: Binding(
                                    get: {
                                        dDayState == state
                                    },
                                    set:  {isSelected in
                                        guard isSelected else {
                                            return
                                        }
                                        dDayState = state
                                    }
                                )
                            )
                        }
                    }
                    
                    Spacer()
                        .frame(height: 56.adjustedH)
                    
                    if let state = dDayState {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 0) {
                                switch state {
                                case .yes:
                                    TypographyText("언제까지 회복이 완료되면 좋을까요?", style: .title1_sb_18, color: .gray1000)
                                        .frame(height: 27.adjustedH)
                                case .no:
                                    TypographyText("대략적인 회복 목표일을 정해볼까요?", style: .title1_sb_18, color: .gray1000)
                                        .frame(height: 27.adjustedH)
                                }
                            }
                            Spacer()
                            
                        }
                        
                        Spacer()
                            .frame(height: 24.adjustedH)
                        
                        DateTextBox(year: $year, month: $month, day: $day)
                            .id("inputField")
                            .padding(.bottom, 12.adjustedH)
                        TreatmentWarningMessgeView(text: warningMessage)
                        
                        Spacer()
                            .frame(height: keyboardHeight)
                    }
                    
                }
                
                .padding(.horizontal, 34.adjustedW)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    keyboardHeight = keyboardFrame.height
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                withAnimation(.easeOut(duration: 0.25)) {
                    keyboardHeight = 0
                }
            }
            .onChange(of: keyboardHeight) { _, newValue in
                if newValue > 0 {
                    withAnimation(.easeOut(duration: 0.25)) {
                        proxy.scrollTo("inputField", anchor: .center)
                    }
                }
            }
        }
    }
}


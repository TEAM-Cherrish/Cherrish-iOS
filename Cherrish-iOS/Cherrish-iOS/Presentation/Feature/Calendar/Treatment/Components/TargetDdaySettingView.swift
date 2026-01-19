//
//  TargetDdaySettingView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/15/26.
//

import SwiftUI

enum DdayState: CaseIterable {
    case yes
    case no
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
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Spacer()
                    .frame(height: 50.adjustedH)
                
                HStack(spacing:0){
                    VStack(alignment: .leading, spacing: 0) {
                        TypographyText("회복을 계획할 때 고려해야 할", style: .title1_sb_18, color: .gray1000)
                        
                        TypographyText("중요한 일정이 있나요?", style: .title1_sb_18, color: .gray1000)
                        
                    }
                    
                    Spacer()
                }
                .frame(height: 54.adjustedH)
                
                Spacer()
                    .frame(height: 40)
                
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
                        switch state {
                        case .yes:
                            TypographyText("언제까지 회복이 완료되면 좋을까요?", style: .title1_sb_18, color: .gray1000)
                        case .no:
                            TypographyText("대략적인 회복 목표일을 정해볼까요?", style: .title1_sb_18, color: .gray1000)
                        }
                        
                        Spacer()

                    }
                    .frame(height: 27.adjustedH)
                    
                    Spacer()
                        .frame(height: 24.adjustedH)
                    
                    DateTextBox(year: $year, month: $month, day: $day)
                }
            }
        }
        .scrollDismissesKeyboard(.interactively)
    }
}


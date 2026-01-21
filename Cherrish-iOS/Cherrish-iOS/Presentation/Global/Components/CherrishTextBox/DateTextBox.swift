//
//  DateTextBox.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/13/26.
//

import SwiftUI

struct DateTextBox: View {
    @Binding var year: String
    @Binding var month: String
    @Binding var day: String
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                TypographyText("날짜", style: .body1_sb_14, color: .gray1000)
                    .frame(height: 20.adjustedH)
                Spacer()
            }
            HStack(spacing: 14){
                DateLabel(text: $year, placeholderStyle: .year)
                DateLabel(text: $month, placeholderStyle: .month)
                DateLabel(text: $day, placeholderStyle: .day)
            }
        }
    }
}

private struct DateLabel: View {
    @Binding var text: String
    let placeholderStyle: DateTextFieldStyle
    var body: some View {
        HStack(spacing: 4) {
            CherrishTextField(
                text: $text,
                style: .date(
                    placeholder: placeholderStyle
                )
            )
            TypographyText(
                placeholderStyle.kr,
                style: .title2_m_16,
                color: .gray700
            )
        }
    }
}


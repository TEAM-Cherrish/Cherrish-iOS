//
//  MonthPlan.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/13/26.
//

import SwiftUI

struct MonthPlan: View {
    let interaction: String
    let dDay: Int
    let tag: String
    private static let textColor: Color = .gray900
    
    var body: some View {
        HStack(spacing: 0) {
            TypographyText(interaction, style: .body1_m_14, color: Self.textColor)
            TypographyText(" • ", style: .body1_m_14, color: Self.textColor)
            TypographyText("회복 \(dDay)일차", style: .body1_r_14, color: Self.textColor)
            
            Spacer()
                .frame(width: 6.adjustedW)
            
            TypographyText(tag, style: .body3_r_12, color: .gray700)
                .frame(width: 32.adjustedW, height: 22.adjustedH)
                .padding(.horizontal, 8.adjustedW)
                .padding(.vertical, 2.adjustedH)
                .background(
                    RoundedRectangle(cornerRadius: 20.adjustedW)
                        .strokeBorder(.gray400, lineWidth: 1.adjustedW)
                )
            
            Spacer()
        }
        .padding(.vertical, 12.adjustedH)
        .padding(.horizontal, 14.adjustedW)
        .background(.gray0)
        .clipShape(RoundedRectangle(cornerRadius: 10.adjustedW))
        .overlay(
            RoundedRectangle(cornerRadius: 10.adjustedW)
                .strokeBorder(.gray400, lineWidth: 1.adjustedW)
        )
    }
}

#Preview {
    MonthPlan(interaction: "복합 박피", dDay: 7, tag: "주의기")
        .padding()
}

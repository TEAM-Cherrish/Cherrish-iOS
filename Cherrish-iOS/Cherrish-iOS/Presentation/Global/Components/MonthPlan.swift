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
                .frame(width: 6)
            
            TypographyText(tag, style: .body3_r_12, color: .gray700)
                .frame(width: 32, height: 22)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.gray400, lineWidth: 1)
                )
            
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .background(.gray0)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(.gray400, lineWidth: 1)
        )
    }
}

#Preview {
    MonthPlan(interaction: "복합 박피", dDay: 7, tag: "주의기")
        .padding()
}

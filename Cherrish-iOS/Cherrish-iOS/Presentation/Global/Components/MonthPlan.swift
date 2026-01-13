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
    private static let tagTextColor: Color = .gray700
    private static let tagBorderColor: Color = .gray400
    private static let containerBorderColor: Color = .gray400
    private static let containerBackgroundColor: Color = .gray0
    
    private static let tagSpacing: CGFloat = 6
    private static let tagPaddingHorizontal: CGFloat = 8
    private static let tagPaddingVertical: CGFloat = 2
    private static let tagBorderWidth: CGFloat = 1
    private static let tagCornerRadius: CGFloat = 20
    private static let containerPaddingVertical: CGFloat = 12
    private static let containerPaddingLeading: CGFloat = 14
    private static let cornerRadius: CGFloat = 10
    private static let containerBorderWidth: CGFloat = 1
    
    var body: some View {
        HStack(spacing: 0) {
            
            TypographyText(interaction, style: .body1_m_14, color: Self.textColor)
            
            TypographyText(" • ", style: .body1_m_14, color: Self.textColor)
            
            TypographyText("회복 \(dDay)일차", style: .body1_r_14, color: Self.textColor)
            
            Spacer()
                .frame(width: Self.tagSpacing)
            
            TypographyText(tag, style: .body3_r_12, color: Self.tagTextColor)
                .frame(width: 32, height: 22)
                .padding(.horizontal, Self.tagPaddingHorizontal)
                .padding(.vertical, Self.tagPaddingVertical)
                .background(
                    RoundedRectangle(cornerRadius: Self.tagCornerRadius)
                        .strokeBorder(Self.tagBorderColor, lineWidth: Self.tagBorderWidth)
                )
            
            Spacer()
        }
        .padding(.vertical, Self.containerPaddingVertical)
        .padding(.leading, Self.containerPaddingLeading)
        .background(Self.containerBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: Self.cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: Self.cornerRadius)
                .strokeBorder(Self.containerBorderColor, lineWidth: Self.containerBorderWidth)
        )
    }
}

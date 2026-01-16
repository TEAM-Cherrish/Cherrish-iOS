//
//  OnComingCard.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/14/26.
//

import SwiftUI

struct OnComingCard: View {
    let date: String
    let name: String
    let count: Int
    let dDay: Int
    var onTap: (() -> Void)? = nil
    
    private var displayName: String {
        guard count > 1 else { return name }
        return "\(name) 외 \(count - 1)건"
    }
    
    private var dDayText: String {
        dDay == 0 ? "D-Day" : "D-\(dDay)"
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 2.adjustedH) {
                TypographyText(date.toKoreanMonthDay, style: .body1_m_14, color: .gray700)
                    .frame(height: 20.adjustedH)
                
                TypographyText(displayName, style: .title2_m_16, color: .gray900)
                    .frame(height: 24.adjustedH)
            }
            
            Spacer()
            
            HStack(spacing: 12.adjustedW) {
                TypographyText(dDayText, style: .body3_r_12, color: .gray600)
                    .frame(width: 40.adjustedW, height: 18.adjustedH)
                    .background(Color("gray_200"))
                    .cornerRadius(20.adjustedW)
                
                Image(.chevronRight)
                    .renderingMode(.template)
                    .gray700()

            }
            .padding(.trailing, 16)
            .padding(.vertical, 1.adjustedH)
        }
    }
}

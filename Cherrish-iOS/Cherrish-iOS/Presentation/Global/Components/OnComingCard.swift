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
    let dDay: Int
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 2.adjustedH) {
                TypographyText(date.toKoreanMonthDay, style: .body1_m_14, color: .gray700)
                    .frame(height: 20.adjustedH)
                
                TypographyText(name, style: .title2_m_16, color: .gray900)
                    .frame(height: 24.adjustedH)
            }
            
            Spacer()
            
            HStack(spacing: 12.adjustedW) {
                TypographyText("D-\(dDay)", style: .body3_r_12, color: .gray600)
                    .frame(width: 40.adjustedW, height: 18.adjustedH)
                    .background(Color("gray_200"))
                    .cornerRadius(20.adjustedW)
                
                Image(.chevronRight)
                    .renderingMode(.template)
                    .gray700()

            }
            .padding(.vertical, 1.adjustedH)
        }
    }
}

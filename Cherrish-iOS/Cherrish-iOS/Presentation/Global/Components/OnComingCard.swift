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
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let parsedDate = formatter.date(from: date) else {
            return date
        }
        
        formatter.dateFormat = "M월 d일"
        return formatter.string(from: parsedDate)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 2.adjustedH) {
                TypographyText(formattedDate, style: .body1_m_14, color: Color("gray_700"))
                    .frame(height: 20.adjustedH)
                
                TypographyText(name, style: .title2_m_16, color: Color("gray_900"))
                    .frame(height: 24.adjustedH)
            }
            
            Spacer()
            
            HStack(spacing: 12.adjustedW) {
                TypographyText("D-\(dDay)", style: .body3_r_12, color: Color("gray_600"))
                    .frame(width: 40.adjustedW, height: 18.adjustedH)
                    .background(Color("gray_200"))
                    .cornerRadius(20.adjustedW)
                
                Image("chevron_left_gray")

            }
            .padding(.vertical, 1.adjustedH)
        }
    }
}

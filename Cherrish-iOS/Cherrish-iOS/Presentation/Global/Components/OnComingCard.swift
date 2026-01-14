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
            VStack(alignment: .leading, spacing: 2) {
                Text(formattedDate)
                    .typography(.body1_m_14)
                    .gray700()
                    .frame(height: 20)
                
                Text(name)
                    .typography(.title2_m_16)
                    .gray900()
                    .frame(height: 24)
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                Text("D-\(dDay)")
                    .typography(.body3_r_12)
                    .gray600()
                    .frame(width: 40, height: 18)
                    .background(Color("gray_200"))
                    .cornerRadius(20)
                
                Image("chevron_left_gray")

            }
            .padding(.vertical, 1)
        }
    }
}

//
//  DateTextField.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/13/26.
//

import SwiftUI

enum DateTextFieldStyle: String {
    case year = "YYYY"
    case month = "MM"
    case day = "DD"
    
    var kr: String {
        switch self {
        case .year:
            "년"
        case .month:
            "월"
        case .day:
            "일"
        }
    }
}

struct DateTextField: View {
    @Binding var text: String
    let placeholder: DateTextFieldStyle
    
    var body: some View {
        HStack(spacing: 0){
            ZStack {
                if text.isEmpty {
                    HStack(alignment: .center){
                        TypographyText(placeholder.rawValue, style: .title2_r_16, color: .gray500)
                        
                    }
                    
                }
                TextField("" ,text: $text)
                    .gray1000()
                    .multilineTextAlignment(.center)
                    .typography(.title2_m_16)
                    .tint(.gray1000)
                    .keyboardType(.numberPad)
            }
            .frame(height: 24.adjustedH)
        }
        .padding(.horizontal, 18.5.adjustedH)
        .padding(.vertical, 8.adjustedW)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray500, lineWidth: 1)
        }
        .frame(height: 40.adjustedH)
    }
}

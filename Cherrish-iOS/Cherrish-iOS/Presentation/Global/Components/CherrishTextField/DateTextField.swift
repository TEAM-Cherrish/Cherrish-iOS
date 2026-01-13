//
//  DateTextField.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/13/26.
//

import SwiftUI

enum DetaTextFieldStyle: String {
    case year = "YYYY"
    case month = "MM"
    case day = "DD"
}

struct DateTextField: View {
    @Binding var text: String
    let placeholder: DetaTextFieldStyle
    
    var body: some View {
        HStack(spacing: 0){
            ZStack {
                if text.isEmpty {
                    HStack(alignment: .center){
                        TypographyText(placeholder.rawValue, style: .title2_r_16)
                            .gray600()
                    }
                    
                }
                TextField("" ,text: $text)
                    .foregroundStyle(.gray1000)
                    .multilineTextAlignment(.center)
                    .typography(.title2_m_16)
                    .accentColor(.gray1000)
            }
            .frame(height: 24.adjustedH)
        }
        .padding(.horizontal, 16.adjustedH)
        .padding(.vertical, 10.adjustedW)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray500, lineWidth: 1)
        }
        .frame(height: 44.adjustedH)
    }
}

#Preview {
    DateTextField(text: Binding.constant(""), placeholder: .year)
}

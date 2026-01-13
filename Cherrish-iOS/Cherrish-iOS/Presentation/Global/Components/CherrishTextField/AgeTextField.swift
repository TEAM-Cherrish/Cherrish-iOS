//
//  AgeTextField.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/13/26.
//

import SwiftUI

struct AgeTextField: View {
    @Binding var text: String
    let placeholder: String
    var body: some View {
        
        HStack(spacing: 0){
            ZStack {
                if text.isEmpty {
                    HStack{
                        TypographyText(placeholder, style: .body1_r_14, color: .gray600)
                        Spacer()
                    }
                    
                }
                TextField("" ,text: $text)
                    .gray1000()
                    .multilineTextAlignment(.leading)
                    .keyboardType(.numberPad)
                    .typography(.body1_m_14)
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
        .frame(height: 44)
         
    }
}



//
//  AgeTextBox.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/13/26.
//

import SwiftUI

struct AgeTextBox: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TypographyText("나이", style: .body1_sb_14,color: .gray1000)
                Spacer()
            }
            Spacer()
                .frame(height: 8)
            AgeTextField(text: $text, placeholder: placeholder)
        }
        
    }
    
}


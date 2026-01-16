//
//  AgeTextBox.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/13/26.
//

import SwiftUI

struct CherrishTextBox: View {
    var title: String
    @Binding var text: String
    let placeholder: String
    var isNumberField: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TypographyText(title, style: .body1_sb_14,color: .gray1000)
                Spacer()
            }
            Spacer()
                .frame(height: 8.adjustedH)
            CherrishTextField(
                text: $text,
                style: isNumberField ? .number(placeholder: placeholder) : .plain(placeholder: placeholder)
            )
        }   
    }
}

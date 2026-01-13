//
//  CheckBox.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/12/26.
//

import SwiftUI

struct CheckBoxComponent: View {
    private enum CheckBoxStyle {
        static let borderColor = Color(.gray500)
        static let checkedTextColor = Color(.gray500)
        static let uncheckedTextColor = Color(.gray800)
        
        static let checkboxSize: CGFloat = 24
        static let containerCornerRadius: CGFloat = 10
        
        static let horizontalSpacing: CGFloat = 6
        static let horizontalPadding: CGFloat = 14
        static let verticalPadding: CGFloat = 12
        
        static let animationDuration: Double = 0.2
    }
    
    let text: String
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: CheckBoxStyle.animationDuration)) {
                isChecked.toggle()
            }
        }) {
            HStack(spacing: CheckBoxStyle.horizontalSpacing) {
                Image(isChecked ? "checkbox_active" : "checkbox_default")
                    .frame(width: CheckBoxStyle.checkboxSize, height: CheckBoxStyle.checkboxSize)
                
                TypographyText(text, style: .body1_r_14, color: isChecked ? CheckBoxStyle.checkedTextColor : CheckBoxStyle.uncheckedTextColor)
                    .strikethrough(isChecked, color: CheckBoxStyle.checkedTextColor)
                
                Spacer()
            }
            .padding(.horizontal, CheckBoxStyle.horizontalPadding)
            .padding(.vertical, CheckBoxStyle.verticalPadding)
            .background(
                RoundedRectangle(cornerRadius: CheckBoxStyle.containerCornerRadius)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: CheckBoxStyle.containerCornerRadius)
                    .stroke(CheckBoxStyle.borderColor, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}


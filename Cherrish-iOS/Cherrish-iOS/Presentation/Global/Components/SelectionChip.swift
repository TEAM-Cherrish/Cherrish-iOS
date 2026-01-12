//
//  SelectionChip.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/11/26.
//

import SwiftUI

struct SelectionChip: View {
    
    let title: String
    @Binding var isSelected: Bool

    var body: some View {
        Text(title)
            .typography(.body1_m_14)
            .foregroundStyle(isSelected ? .gray800 : .gray700)
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(isSelected ? .red200 : .gray0)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? .red500 : .gray500, lineWidth: 1)
            )
            .onTapGesture {
                isSelected.toggle()
            }
    }
}

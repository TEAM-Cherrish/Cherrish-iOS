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
        VStack(alignment: .leading) {
            Text(title)
                .typography(.body1_m_14)
                .foregroundStyle(isSelected ? .gray800 : .gray700)
        }
        .frame(width: 148, height: 80)
        .background(isSelected ? .red200 : .gray0)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? .red500 : .gray500, lineWidth: 1)
        )
        .cornerRadius(10)
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

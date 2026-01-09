//
//  SaveButtonActive.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/9/26.
//

import SwiftUI

struct SaveButton: View {
    var body: some View {
        Button{} label: {
            Text("등록하기")
                .typography(.title2_sb_16)
                .foregroundStyle(.gray0)
        }
        .buttonStyle(SaveButtonPressedStyle())
    }
}

struct SaveButtonPressedStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: configuration.isPressed ? 264.1 : 278,
                   height: configuration.isPressed ? 41.8 : 44)
            .background(Color.red700)
            .cornerRadius(configuration.isPressed ? 9.5 : 10)
    }
}


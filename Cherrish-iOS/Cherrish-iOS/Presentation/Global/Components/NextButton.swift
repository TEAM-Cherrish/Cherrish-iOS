//
//  NextButton.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/8/26.
//

import SwiftUI

struct NextButton: View {
    
    @State private var isActive: Bool = false
    
    var body: some View {
        Button{} label: {
            Text("다음")
                .typography(.title2_sb_16)
                .foregroundStyle(isActive ? .gray0 : .gray600)
        }
        .buttonStyle(NextButtonPressedStyle(
            isActive: isActive
        ))
    }
}

struct NextButtonPressedStyle: ButtonStyle {
    
    let isActive: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: configuration.isPressed ? 309.7 : 326,
                   height: configuration.isPressed ? 47.5 : 50)
            .background(isActive ? Color.red700 : Color.gray200)
            .cornerRadius(configuration.isPressed ? 11.4 : 12)
    }
}

#Preview {
    NextButton()
}

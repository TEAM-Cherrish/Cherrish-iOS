//
//  Untitled.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/9/26.
//

import SwiftUI

struct AddEventButton: View {
    
    var body: some View {
        Button{} label: {
            Text("다운타임 없이 일정 추가")
                .typography(.title2_sb_16)
                .foregroundStyle(.gray700)
        }
        .buttonStyle(AddButtonPressedStyle())
    }
}

struct AddButtonPressedStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: configuration.isPressed ? 186.2 : 196,
                   height: configuration.isPressed ? 47.5 : 50)
            .background(Color.gray400)
            .cornerRadius(configuration.isPressed ? 11.4 : 12)
    }
}


#Preview {
    AddEventButton()
}

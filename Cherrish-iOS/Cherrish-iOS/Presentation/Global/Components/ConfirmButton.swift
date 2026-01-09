    //
//  ConfirmButton.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/9/26.
//

import SwiftUI

struct ConfirmButton: View {
    var body: some View {
        Button{} label: {
            Text("확인")
                .typography(.title2_sb_16)
                .foregroundStyle(.gray0)
        }
        .buttonStyle(ConfirmButtonPressedStyle())
    }
}

struct ConfirmButtonPressedStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: configuration.isPressed ? 119.7 : 126,
                   height: configuration.isPressed ? 47.5 : 50)
            .background(Color.red700)
            .cornerRadius(configuration.isPressed ? 11.4 : 12)
    }
}


#Preview {
    ConfirmButton()
}

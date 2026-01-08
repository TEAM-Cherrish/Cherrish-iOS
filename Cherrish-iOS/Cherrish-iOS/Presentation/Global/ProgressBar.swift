//
//  ProgressBar.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/9/26.
//

import SwiftUI

struct ProgressBar: View {
    var totalSteps: Int
    var currentStep: Int
    
    private let backgroundColor: Color = Color(.gray300)
    private let progressColor: Color = Color(.gray800)
    private let height: CGFloat = 4
    private let cornerRadius: CGFloat = 76
    private let spacing: CGFloat = 4
    
    @State private var isAppeared = false
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<totalSteps, id: \.self) { index in
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(index < currentStep ? progressColor : backgroundColor)
                    .frame(height: height)
                    .scaleX(isAppeared ? 1 : 0)
                    .animation(
                        .easeOut(duration: 0.4).delay(Double(index) * 0.08),
                        value: isAppeared
                    )
            }
        }
        .frame(height: height)
        .onAppear {
            isAppeared = true
        }
    }
}

extension View {
    func scaleX(_ scale: CGFloat) -> some View {
        self.scaleEffect(x: scale, y: 1, anchor: .leading)
    }
}


//
//  PageIndicator.swift
//  Cherrish-iOS
//
//  Created by Cherrish on 1/15/26.
//

import SwiftUI

struct PageIndicator: View {
    let currentPage: Int
    let totalPages: Int
    
    private let dotSize: CGFloat = 8
    private let dotSpacing: CGFloat = 8
    
    var body: some View {
        HStack(spacing: dotSpacing) {
            ForEach(0..<totalPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? .gray800 : .gray500)
                    .frame(width: dotSize, height: dotSize)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        PageIndicator(currentPage: 0, totalPages: 2)
        PageIndicator(currentPage: 1, totalPages: 2)
    }
}

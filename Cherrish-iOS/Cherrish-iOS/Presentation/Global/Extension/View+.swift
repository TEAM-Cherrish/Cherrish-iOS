//
//  View+.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/15/26.
//

import SwiftUI

extension View {
    func highlight(
        highlightText: String,
        highlightColor: Color = .red700,
        normalText: String
    ) -> some View {
        HStack {
            TypographyText(highlightText, style: .title1_sb_18, color: highlightColor)
            TypographyText(normalText, style: .title1_sb_18, color: .gray800)
        }
    }
}

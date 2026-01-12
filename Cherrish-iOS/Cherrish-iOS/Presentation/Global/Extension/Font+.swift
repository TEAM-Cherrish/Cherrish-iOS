//
//  Font+.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/8/26.
//
import SwiftUI

enum PretendardWeight: String {
    case bold = "Pretendard-Bold"
    case semiBold = "Pretendard-SemiBold"
    case medium = "Pretendard-Medium"
    case regular = "Pretendard-Regular"
}

struct Typography {
    let font: Font
    let tracking: CGFloat
    let lineHeight: CGFloat
    let size: CGFloat
    
    var lineSpacing: CGFloat {
        return lineHeight - size
    }
    
    init(weight: PretendardWeight, size: CGFloat, spacingPercent: CGFloat, lineHeightPercent: CGFloat) {
        self.font = .custom(weight.rawValue, size: size)
        self.tracking = size * (spacingPercent / 100)
        self.lineHeight = size * (lineHeightPercent / 100)
        self.size = size
    }
}

extension Typography {
    
    static let headline_b_20 = Typography(weight: .bold, size: 20, spacingPercent: 1, lineHeightPercent: 150)
    static let headline_sb_20 = Typography(weight: .semiBold, size: 20, spacingPercent: 1, lineHeightPercent: 150)
    
    static let title1_sb_18 = Typography(weight: .semiBold, size: 18, spacingPercent: 1, lineHeightPercent: 150)
    static let title1_m_18 = Typography(weight: .medium, size: 18, spacingPercent: 1, lineHeightPercent: 150)
    static let title1_r_18 = Typography(weight: .regular, size: 18, spacingPercent: 1, lineHeightPercent: 150)
    
    static let title2_sb_16 = Typography(weight: .semiBold, size: 16, spacingPercent: 0, lineHeightPercent: 150)
    static let title2_m_16 = Typography(weight: .medium, size: 16, spacingPercent: 0, lineHeightPercent: 150)
    static let title2_r_16 = Typography(weight: .regular, size: 16, spacingPercent: 0, lineHeightPercent: 150)
    
    static let body1_sb_14 = Typography(weight: .semiBold, size: 14, spacingPercent: 0, lineHeightPercent: 140)
    static let body1_m_14 = Typography(weight: .medium, size: 14, spacingPercent: 0, lineHeightPercent: 140)
    static let body1_r_14 = Typography(weight: .regular, size: 14, spacingPercent: 0, lineHeightPercent: 140)
    
    static let body2_r_13 = Typography(weight: .regular, size: 13, spacingPercent: 0, lineHeightPercent: 140)
    
    static let body3_m_12 = Typography(weight: .medium, size: 12, spacingPercent: 0, lineHeightPercent: 140)
    static let body3_r_12 = Typography(weight: .regular, size: 12, spacingPercent: 0, lineHeightPercent: 140)
    
    static let caption_r_11 = Typography(weight: .regular, size: 11, spacingPercent: 0, lineHeightPercent: 140)
}

extension View {
    func typography(_ style: Typography) -> some View {
        self
            .font(style.font)
            .tracking(style.tracking)
            .lineSpacing(style.lineSpacing)
    }
}

extension Font {
    static func pretendard(_ weight: PretendardWeight, size: CGFloat) -> Font {
        return .custom(weight.rawValue, size: size)
    }
}

struct TypographyText: View {
    let text: String
    let style: Typography
    let color: Color
    
    init(_ text: String, style: Typography, color: Color = .primary) {
        self.text = text
        self.style = style
        self.color = color
    }
    
    var body: some View {
        Text(text)
            .typography(style)
            .foregroundStyle(color)
    }
}


//
//  Font+.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/8/26.
//
import SwiftUI

// MARK: - Pretendard Font Weight
enum PretendardWeight: String {
    case bold = "Pretendard-Bold"
    case semiBold = "Pretendard-SemiBold"
    case medium = "Pretendard-Medium"
    case regular = "Pretendard-Regular"
}

// MARK: - Typography Style
struct Typography {
    let font: Font
    let tracking: CGFloat
    
    init(weight: PretendardWeight, size: CGFloat, spacingPercent: CGFloat) {
        self.font = .custom(weight.rawValue, size: size)
        self.tracking = size * (spacingPercent / 100)
    }
}

// MARK: - Typography Extension
extension Typography {
    
    // MARK: - Headline (Size: 20, Spacing: 1%)
    static let headline_b_20 = Typography(weight: .bold, size: 20, spacingPercent: 1)
    static let headline_sb_20 = Typography(weight: .semiBold, size: 20, spacingPercent: 1)
    
    // MARK: - Title 1 (Size: 18, Spacing: 1%)
    static let title1_sb_18 = Typography(weight: .semiBold, size: 18, spacingPercent: 1)
    static let title1_m_18 = Typography(weight: .medium, size: 18, spacingPercent: 1)
    static let title1_r_18 = Typography(weight: .regular, size: 18, spacingPercent: 1)
    
    // MARK: - Title 2 (Size: 16, Spacing: 0%)
    static let title2_sb_16 = Typography(weight: .semiBold, size: 16, spacingPercent: 0)
    static let title2_m_16 = Typography(weight: .medium, size: 16, spacingPercent: 0)
    static let title2_r_16 = Typography(weight: .regular, size: 16, spacingPercent: 0)
    
    // MARK: - Body 1 (Size: 14, Spacing: 0%)
    static let body1_sb_14 = Typography(weight: .semiBold, size: 14, spacingPercent: 0)
    static let body1_m_14 = Typography(weight: .medium, size: 14, spacingPercent: 0)
    static let body1_r_14 = Typography(weight: .regular, size: 14, spacingPercent: 0)
    
    // MARK: - Body 2 (Size: 13, Spacing: 0%)
    static let body2_r_13 = Typography(weight: .regular, size: 13, spacingPercent: 0)
    
    // MARK: - Body 3 (Size: 12, Spacing: 0%)
    static let body3_m_12 = Typography(weight: .medium, size: 12, spacingPercent: 0)
    static let body3_r_12 = Typography(weight: .regular, size: 12, spacingPercent: 0)
    
    // MARK: - Caption (Size: 11, Spacing: 0%)
    static let caption_r_11 = Typography(weight: .regular, size: 11, spacingPercent: 0)
}

// MARK: - View Extension
extension View {
    func typography(_ style: Typography) -> some View {
        self
            .font(style.font)
            .tracking(style.tracking)
    }
}

// MARK: - Custom Font
extension Font {
    static func pretendard(_ weight: PretendardWeight, size: CGFloat) -> Font {
        return .custom(weight.rawValue, size: size)
    }
}

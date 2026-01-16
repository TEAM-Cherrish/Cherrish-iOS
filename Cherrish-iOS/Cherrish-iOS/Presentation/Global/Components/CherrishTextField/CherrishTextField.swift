//
//  AgeTextField.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/13/26.
//

import SwiftUI

enum CherrishTextFieldStyle {
    
    case plain(placeholder: String)
    case number(placeholder: String)
    case date(placeholder: DateTextFieldStyle)
    
    var placeholder: String {
        switch self {
        case .plain(placeholder: let placeholder):
            return placeholder
        case .number(placeholder: let placeholder):
            return placeholder
        case .date(placeholder: let placeholder):
            return placeholder.rawValue
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .plain:
            return .default
        case .number, .date:
            return .numberPad
        }
    }
    
    var placeholderFont: Typography {
        switch self {
        case .plain, .number:
            return .body1_r_14
        case .date:
            return .title2_r_16
        }
    }
    
    var placeholderColor: Color {
        switch self {
        case .plain, .number:
            return .gray600
        case .date:
            return .gray500
        }
    }
    
    var textFont: Typography {
        switch self {
        case .plain, .number:
            return .body1_m_14
        case .date:
            return .title2_m_16
        }
    }
    
    var textColor: Color {
        switch self {
        default:
            return .gray1000
        }
    }
    
    var fontHeight: CGFloat {
        switch self {
        default:
            return 24.adjustedH
        }
    }
    
    var verticalPadding: CGFloat {
        switch self {
        case .plain, .number:
            return 10.adjustedH
        case .date:
            return 8.adjustedH
        }
    }
    
    var backgroundStrokeColor: Color {
        switch self {
        default:
            return .gray500
        }
    }
    
    var textAlinement: TextAlignment {
        switch self {
        case .plain, .number:
            return .leading
        case .date:
            return .center
        }
    }
}

enum DateTextFieldStyle: String {
    case year = "YYYY"
    case month = "MM"
    case day = "DD"
    
    var kr: String {
        switch self {
        case .year:
            "년"
        case .month:
            "월"
        case .day:
            "일"
        }
    }
}


struct CherrishTextField: View {
    @Binding var text: String
    let style: CherrishTextFieldStyle
    var body: some View {
        
        HStack(spacing: 0){
            ZStack {
                if text.isEmpty {
                    HStack{
                        switch style {
                        case .plain, .number:
                            EmptyView()
                        case .date:
                            Spacer()
                        }
                        TypographyText(
                            style.placeholder,
                            style: style.placeholderFont ,
                            color: style.placeholderColor
                        ).fixedSize()
                        Spacer()
                    }
                }
                HStack{
                    Spacer()
                TextField("" ,text: $text)
                    .foregroundStyle(style.textColor)
                    .multilineTextAlignment(style.textAlinement)
                    .keyboardType(style.keyboardType)
                    .typography(style.textFont)
                    .tint(style.textColor)
                    Spacer()
                }
            }
            .frame(height: style.fontHeight)
        }
        .padding(.vertical, style.verticalPadding)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(style.backgroundStrokeColor, lineWidth: 1)
        }
        .frame(height: 44)
    }
}



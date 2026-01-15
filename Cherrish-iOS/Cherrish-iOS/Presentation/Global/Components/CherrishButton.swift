//
//  CherrishButton.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/10/26.
//

import SwiftUI

enum ButtonState {
    case normal
    case active
}

enum CherrishButtonType {
    case large
    case small
    case medium
    case addEvent
}

struct CherrishButton: View {
    
    let title: String
    let type: CherrishButtonType
    var state: ButtonState
    let leadingIcon: Image?
    let trailingIcon: Image? 
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 0){
                Spacer()
                
                if let leadingIcon {
                    leadingIcon
                        .frame(width: 24, height: 24)
                }
                
                Text(title)
                    .typography(.title2_sb_16)
                    .foregroundStyle(type.textColor(for: state))
                
                if let trailingIcon {
                    trailingIcon
                        .frame(width: 24, height: 24)
                }
                
                Spacer()
            }
            
        }
        .buttonStyle(CherrishButtonStyle(state: state, type: type))
        .disabled(type.isDisabled(for: state))
    }
}

struct CherrishButtonStyle: ButtonStyle {
    let state: ButtonState
    let type: CherrishButtonType
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: type.height)
            .background(type.backgroundColor(for: state))
            .clipShape(RoundedRectangle(cornerRadius: configuration.isPressed
                                        ? type.cornerRadius * 0.95
                                        : type.cornerRadius))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension CherrishButtonType {
    
    var height: CGFloat {
        switch self {
        case .medium: return 44.adjustedH
        default:
            return 50.adjustedH
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .medium: return 10
        default: return 12
        }
    }
    
    func backgroundColor(for state: ButtonState) -> Color {
        switch self {
        case .large:
            return state == .active ? .red700 : .gray200
        case .small, .medium:
            return .red700
        case .addEvent:
            return .gray400
        }
    }
    
    func textColor(for state: ButtonState) -> Color {
        switch self {
        case .large:
            return state == .active ? .gray0 : .gray600
        case .small, .medium:
            return .gray0
        case .addEvent:
            return .gray700
        }
    }
    
    func isDisabled(for state: ButtonState) -> Bool {
        switch self {
        case .large:
            return state == .normal
        default:
            return false
        }
    }
}

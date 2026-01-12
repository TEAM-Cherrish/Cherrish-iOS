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
    case next
    case confirm
    case save
    case addEvent
}

struct CherrishButton: View {
    
    let title: String
    let type: CherrishButtonType
    @Binding var state: ButtonState
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .typography(.title2_sb_16)
                .foregroundStyle(type.textColor(for: state))
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
            .frame(
                width: configuration.isPressed ? type.width * 0.95 : type.width,
                height: configuration.isPressed ? type.height * 0.95 : type.height
            )
            .background(type.backgroundColor(for: state))
            .clipShape(RoundedRectangle(cornerRadius: configuration.isPressed
                                        ? type.cornerRadius * 0.95
                                        : type.cornerRadius))
    }
}


extension CherrishButtonType {
    
    var width: CGFloat {
        switch self {
        case .next: return 326
        case .confirm: return 126
        case .save: return 278
        case .addEvent: return 196
        }
    }
    
    var height: CGFloat {
        switch self {
        case .save: return 44
        default:
            return 50
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .save: return 10
        default: return 12
        }
    }
    
    func backgroundColor(for state: ButtonState) -> Color {
        switch self {
        case .next:
            return state == .active ? .red700 : .gray200
        case .confirm, .save:
            return .red700
        case .addEvent:
            return .gray400
        }
    }
    
    func textColor(for state: ButtonState) -> Color {
        switch self {
        case .next:
            return state == .active ? .gray0 : .gray600
        case .confirm, .save:
            return .gray0
        case .addEvent:
            return .gray700
        }
    }
    
    func isDisabled(for state: ButtonState) -> Bool {
        switch self {
        case .next:
            return state == .normal
        default:
            return false
        }
    }
}

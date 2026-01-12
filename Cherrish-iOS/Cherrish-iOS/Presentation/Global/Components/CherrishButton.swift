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
            HStack{
                Spacer()
                Text(title)
                    .typography(.title2_sb_16)
                    .foregroundStyle(type.textColor(for: state))
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


struct CherrishButtonPreviewWrapper: View {
    
    @State private var nextState: ButtonState = .normal
    @State private var activeNextState: ButtonState = .active
    @State private var dummyState: ButtonState = .active

    var body: some View {
        VStack(spacing: 16) {

            // NEXT - 비활성
            CherrishButton(
                title: "다음",
                type: .next,
                state: $nextState
            ) {
                print("Next (normal)")
            }

            // NEXT - 활성
            CherrishButton(
                title: "다음",
                type: .next,
                state: $activeNextState
            ) {
                print("Next (active)")
            }
            .padding(CGFloat(8))

            // CONFIRM
            CherrishButton(
                title: "확인",
                type: .confirm,
                state: $dummyState
            ) {
                print("Confirm")
            }

            // SAVE
            CherrishButton(
                title: "등록하기",
                type: .save,
                state: $dummyState
            ) {
                print("Save")
            }

            // ADD EVENT
            CherrishButton(
                title: "다운타임 없이 일정 추가",
                type: .addEvent,
                state: $dummyState
            ) {
                print("Add Event")
            }
        }
        .padding()
        .background(Color.gray100)
    }
}
#Preview {
    CherrishButtonPreviewWrapper()
}



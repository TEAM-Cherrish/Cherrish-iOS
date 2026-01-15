//
//  CalendarCellView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/12/26.
//

import SwiftUI

enum DowntimeDayState: CaseIterable, Hashable {
    case none
    case sensitive
    case caution
    case recovery
}

struct CalendarCellView: View {
    
    let value: DateValue
    let procedureCount: Int
    let isSelected: Bool
    let downtimeState: DowntimeDayState
    @Binding var calendarMode: CalendarMode
    
    var body: some View {
        ZStack {
            if calendarMode == .selectedProcedure && downtimeState != .none {
                Circle()
                    .fill(downtimeState.backgroundColor)
                    .overlay(
                        Circle()
                            .stroke(downtimeState.strokeColor, lineWidth: 1)
                    )
                    .frame(width: 40.adjustedW, height: 40.adjustedH)
            }
            
            TypographyText("\(value.day)", style: .body1_r_14, color: .gray1000)
            
            if procedureCount > 0 {
                let displayCount = min(procedureCount, 3)
                
                VStack {
                    Spacer()
                    HStack(spacing: 4) {
                        ForEach(0..<displayCount, id: \.self) { _ in
                            scheduleCircle
                        }
                    }
                    .padding(.bottom, 4)
                }
            }
            
            if calendarMode == .none && isSelected {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray500, lineWidth: 1)
            }
        }
        .frame(width: 40.adjustedW, height: 40.adjustedH)
    }
}
extension CalendarCellView {
    private var scheduleCircle: some View {
        Circle()
            .fill(.red700)
            .frame(width: 4, height: 4)
    }
}

extension DowntimeDayState {
    var backgroundColor: Color {
        switch self {
        case .none:
            return .clear
        case .sensitive:
            return .red500
        case .caution:
            return .red300
        case .recovery:
            return .red200
        }
    }
    
    var strokeColor: Color {
        switch self {
        case .none:
            return .clear
        case .sensitive:
            return .red700
        case .caution:
            return .red500
        case .recovery:
            return .red400
        }
    }
    
    var title: String {
        switch self {
        case .none:
            ""
        case .sensitive:
            "민감"
        case .caution:
            "주의"
        case .recovery:
            "회복"
        }
    }
}

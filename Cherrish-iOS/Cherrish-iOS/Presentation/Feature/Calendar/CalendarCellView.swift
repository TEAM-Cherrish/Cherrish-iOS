//
//  CalendarCellView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/12/26.
//

import SwiftUI

enum DaySelectionState {
    case normal
    case selected
}

enum DayDownTimeState {
    case none
    case sensitive
    case caution
    case recovery
}

struct CalendarCellView: View {
    
    let value: DateValue
    let procedureCount: Int
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            TypographyText("\(value.day)", style: .body1_r_14, color: .gray1000)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        
            if procedureCount > 0 {
                let displayCount = min(procedureCount, 3)
                
                HStack(spacing: 4) {
                    ForEach(0..<displayCount, id: \.self) { _ in
                        scheduleCircle
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 4)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .frame(width: 40, height: 40)
        .overlay {
            if isSelected {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray500, lineWidth: 1)
            }
        }
    }
}

extension CalendarCellView {
    private var scheduleCircle: some View {
        Circle()
            .fill(.red700)
            .frame(width: 4, height: 4)
    }
}

extension DayDownTimeState {
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
}

//
//  ProcedureView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/14/26.
//

import SwiftUI

enum ProcedureStatus: String {
    case active
    case dimmed
}

struct ProcedureView: View {
    let treatmentTitle: String
    let treatmentDate: String
    let downTimeDays: String
    @Binding var calendarMode: CalendarMode
    let isSelected: Bool
    
    private var status: ProcedureStatus {
        if isSelected {
            return .active
        }
        
        switch calendarMode {
        case .none:
            return .active
        case .selectedProcedure:
            return .dimmed
        }
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(status.backgroundColor)
            .frame(height: 56.adjustedH)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(status.strokeColor, lineWidth: 1)
            }
            .overlay {
                treatmentDetail
            }
    }
}

extension ProcedureView {
    private var treatmentDetail: some View {
        HStack(alignment: .center) {
            verticalBar
                .padding(.leading, 10.adjustedW)
            
            Spacer()
                .frame(width: 8.adjustedW)
            
            TypographyText(treatmentTitle, style: .body1_sb_14, color: status.titleColor)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 1) {
                TypographyText(treatmentDate.dateFormatter(), style: .body3_r_12, color: status.downtimeTextColor)
                if status == .active {
                    TypographyText("다운타임 \(downTimeDays)일", style: .body3_r_12, color: status.downtimeTextColor)
                }
            }
            .padding(.trailing, 10)
        }
    }
    
    private var verticalBar: some View {
        RoundedRectangle (cornerRadius: 6)
            .fill(status.verticalBarColor)
            .frame(width: 3.adjustedW, height: 34.adjustedH)
    }
}

extension ProcedureStatus {
    var backgroundColor: Color {
        switch self {
        case .active:
            return .gray0
        case .dimmed:
            return .gray100
        }
    }
    
    var strokeColor: Color {
        switch self {
        case .active:
            return .gray500
        case .dimmed:
            return .clear
        }
    }
    
    var verticalBarColor: Color {
        switch self {
        case .active:
            return .red600
        case .dimmed:
            return .gray300
        }
    }
    
    var titleColor: Color {
        switch self {
        case .active:
            return .gray900
        case .dimmed:
            return .gray500
        }
    }
    
    var downtimeTextColor: Color {
        switch self {
        case .active:
            return .gray800
        case .dimmed:
            return .gray500
        }
    }
}

//
//  ProcedureView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/14/26.
//

import SwiftUI

struct ProcedureView: View {
    let treatmentTitle: String
    let treatmentDate: String
    let downTimeDays: Int
    
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(.gray0)
            .frame(height: 56.adjustedH)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(.gray500, lineWidth: 1) 
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
                .padding(.leading, 10)
            
            TypographyText(treatmentTitle, style: .body1_sb_14, color: .gray900)
                .padding(.leading, 8)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 1) {
                TypographyText(treatmentDate.dateFormatter(), style: .body3_r_12, color: .gray800)
                
                TypographyText("다운타임 \(downTimeDays)일", style: .body3_r_12, color: .gray800)
            }
            .padding(.trailing, 10)
        }
    }
    
    private var verticalBar: some View {
        RoundedRectangle (cornerRadius: 6)
            .fill(.red600)
            .frame(width: 3.adjustedW, height: 34.adjustedH)
    }
}

//
//  TreatmentWarningMessgeView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/21/26.
//

import SwiftUI

struct TreatmentWarningMessgeView: View {
    let text: String
    var body: some View {
        HStack(spacing: 0) {
            TypographyText(text, style: .body1_r_14, color: .red700)
                .frame(height: 20.adjustedH)
            Spacer()
        }
        
    }
}

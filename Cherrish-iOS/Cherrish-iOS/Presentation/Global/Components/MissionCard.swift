//
//  MissionCard.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/11/26.
//

import SwiftUI

struct MissionCard: View {
    let missionText: String
    @Binding var isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(isSelected ? .radiobtnSelected : .radiobtnDefault)
                    .padding(.leading, 14.adjustedW)
                    .padding(.vertical, 14.adjustedH)
                TypographyText(missionText, style: .body1_r_14, color: isSelected ? .gray800 : .gray700)
                Spacer()
            }
        }
        .background(isSelected ? .red100 : .gray0)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? .red500 : .gray500, lineWidth: 1)
        )
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

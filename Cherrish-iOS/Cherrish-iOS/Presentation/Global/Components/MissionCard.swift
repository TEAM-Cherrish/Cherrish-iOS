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
                Spacer()
                Image(isSelected ? "radiobtn_selected" : "radiobtn_default")
            }
            
            Spacer()
            
            Text(missionText)
                .typography(.body1_m_14)
                .foregroundStyle(isSelected ? .gray800 : .gray700)
                .padding(.leading, 8)
                .padding(.bottom, 6)
        }
        .padding(.horizontal, 7)
        .padding(.vertical, 6)
        .frame(width: 148, height: 80)
        .background(isSelected ? .red200 : .gray0)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? .red500 : .gray500, lineWidth: 1)
        )
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

//
//  DownTimeSettingView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import SwiftUI

struct DownTimeSettingView: View {
    @State var selectedTreatment: TreatmentEntity? = nil
    @Binding var treatments: [TreatmentEntity]
    let setday: (year: Int, month: Int, day: Int)
    let today: (year: Int, month: Int, day: Int)
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 30.adjustedH)
            
            HStack {
                TypographyText(
                    "필요에 맞게 다운타임을 조정할 수 있어요.",
                    style: .title1_sb_18,
                    color: .gray1000
                )
                
                Spacer()
                
            }
            .padding(.horizontal, 25.adjustedW)
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Spacer()
                        .frame(height: 24.adjustedH)
                    ForEach(treatments, id: \.self) { treatment in
                        TreatmentRowView(
                            displayMode: .completeBoxView,
                            treatmentEntity: treatment,
                            isSelected: .constant(
                                selectedTreatment == treatment
                                
                            ),
                            isCompleted: .constant(
                                treatment.setDowntime == nil ? false : true
                            ),
                            action: {
                                selectedTreatment = treatment
                            })
                    }
                    
                    Spacer()
                        .frame(height: 14.adjustedH)
                    
                    HStack(alignment: .top, spacing: 0) {
                        TypographyText(
                            "◎",
                            style: .body3_r_12,
                            color: .gray600
                        )
                        
                        VStack(alignment: .leading, spacing: 0) {
                            TypographyText(
                                "본 정보는 의료 상담이나 진단을 대체하지 않으며,",
                                style: .body3_r_12,
                                color: .gray600
                            )
                            
                            TypographyText(
                                "실제 다운타임 및 회복 과정은 개인에 따라 다를 수 있습니다.",
                                style: .body3_r_12,
                                color: .gray600
                            )
                            
                            TypographyText(
                                "정확한 내용은 의료진 상담을 통해 확인하세요.",
                                style: .body3_r_12,
                                color: .gray600
                            )
                            
                        }
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 25.adjustedW)
            }
            
        }
        .sheet(item: $selectedTreatment) { treatment in
            if let index = treatments.firstIndex(where: { $0.id == treatment.id }) {
                DowntimeBottomSheetView(
                    treatment: $treatments[index],
                    selectedTreatment: $selectedTreatment,
                    today: today,
                    setday: setday
                )
                .presentationDetents([.extraLarge])
                .presentationBackground(.gray0)
                .presentationDragIndicator(.visible)
            }
            
            
        }
    }
}

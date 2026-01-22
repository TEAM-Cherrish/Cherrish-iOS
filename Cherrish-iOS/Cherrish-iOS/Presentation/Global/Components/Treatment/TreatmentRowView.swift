//
//  TreatmentRowView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/12/26.
//

import SwiftUI

struct TreatmentRowView: View {
    let displayMode: TreatmentDisplayMode
    let treatmentEntity: TreatmentEntity
    @Binding var isSelected: Bool
    @Binding var isCompleted: Bool
    let action: () -> Void
    
    init(
        displayMode: TreatmentDisplayMode,
        treatmentEntity: TreatmentEntity,
        isSelected: Binding<Bool>,
        isCompleted: Binding<Bool>? = nil,
        action: @escaping () -> Void
    ) {
        self.displayMode = displayMode
        self.treatmentEntity = treatmentEntity
        self._isSelected = isSelected
        self._isCompleted = isCompleted ?? .constant(false)
        self.action = action
    }
    
    var body: some View {
        switch displayMode {
        case .summary:
            TreatmentSummaryView(treatmentEntity, action: action)
            
        case .checkBoxView:
            TreatmentCheckBoxView(treatmentEntity, isSelected: $isSelected, isCompleted: $isCompleted, action: action)
            
        case .completeBoxView:
            TreatmentCheckBoxView(treatmentEntity, isSelected: $isSelected, isCompleted: $isCompleted, isCompletedView: true, action: action)
        }
    }
}

private struct TreatmentSummaryView: View {
    let treatmentEntity: TreatmentEntity
    let action: () -> Void
    
    init(
        _ treatmentEntity: TreatmentEntity,
        action: @escaping () -> Void
    ) {
        self.treatmentEntity = treatmentEntity
        self.action = action
    }
    
    var body: some View {
        HStack(spacing: 0) {
            TypographyText(
                treatmentEntity.name,
                style: .body1_r_14,
                color: .gray800
            )
            Spacer()
                .frame(width: 12.adjustedW)
            TypographyText(
                "|",
                style: .body2_r_13,
                color: .gray600
            )
            Spacer()
                .frame(width: 12.adjustedW)
            TypographyText(
                treatmentEntity.downtimeMin == 0 && treatmentEntity.downtimeMax == 0 ?
                "다운타임* 0일" :
                "다운타임*  \(treatmentEntity.downtimeMin)-\(treatmentEntity.downtimeMax)일",
                style: .body1_r_14,
                color: .gray700
            )
            
            
            Spacer()
            Image(.deletebox)
                .onTapGesture {
                    action()
                }
        }
        .frame(height: 20.adjustedH)
        .padding(.leading, 17.adjustedW)
        .padding(.trailing, 10.adjustedW)
        .padding(.vertical, 7.adjustedH)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(.gray200)
        )
    }
}


private struct TreatmentCheckBoxView: View {
    let treatmentEntity: TreatmentEntity
    @Binding var isSelected: Bool
    @Binding var isCompleted: Bool
    let isCompletedView: Bool
    let action: () -> Void
    
    init(
        _ treatmentEntity: TreatmentEntity,
        isSelected: Binding<Bool>,
        isCompleted: Binding<Bool>,
        isCompletedView: Bool = false,
        action: @escaping () -> Void
        ) {
            self.treatmentEntity = treatmentEntity
            self._isSelected = isSelected
            self._isCompleted = isCompleted
            self.isCompletedView = isCompletedView
            self.action = action
            
        }
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TypographyText(treatmentEntity.name, style: .title1_sb_18, color: .gray1000)
                    .frame(height: 24.adjustedH)
                Spacer()
                if isCompletedView{
                    Image(isCompleted ? .checkCircular : .checkCircularGray)
                }
            }
            HStack(spacing: 0) {
                TypographyText(
                    treatmentEntity.benefits.joinedWithSeparator(),
                    style: .body3_r_12,
                    color: .gray700
                )
                .frame(height: 18.adjustedH)
                Spacer()
            }
            
            Spacer()
            DownTimeLabel(downtimeMin: treatmentEntity.downtimeMin, downtimeMax: treatmentEntity.downtimeMax)
        }
        .padding(.vertical, 12.adjustedH)
        .padding(.horizontal, 14.adjustedW)
        .frame(height: 100.adjustedH)
        .background {
            if isCompleted {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.green1)
                
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(isSelected ? .gray300 : Color.white)
                
            }
        }
        .overlay{
            if isCompleted {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.green2, lineWidth: 1)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray500, lineWidth: 1)
            }
            
        }
        .onTapGesture {
            action()
            if !isCompleted {
                isSelected.toggle()
            }
            
        }
    }
}

private struct DownTimeLabel: View {
    let downtimeMin: Int
    let downtimeMax: Int
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            Spacer()
            Image(.clock)
                .gray700()
                .frame(width: 24.adjustedH, height: 24.adjustedH)
            TypographyText(
                downtimeMin == 0 && downtimeMax == 0 ?
                "다운타임* 0일" :
                "다운타임*  \(downtimeMin)-\(downtimeMax)일",
                style: .body2_r_13,
                color: .gray700
            )
            .frame(height: 18.adjustedH)
        }
    }
}

//
//  TreatmentRowView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/12/26.
//

import SwiftUI

struct TreatmentRowView: View {
    let displayMode: TreatmentDisplayMode
    let treatmentModel: TreatmentModel
    @Binding var isSelected: Bool
    var isCompleted: Binding<Bool>?
    let action:  () -> Void
    
    init(displayMode: TreatmentDisplayMode, treatmentModel: TreatmentModel, isSelected: Binding<Bool>, isCompleted: Binding<Bool>? = nil, action: @escaping () -> Void) {
        self.displayMode = displayMode
        self.treatmentModel = treatmentModel
        self._isSelected = isSelected
        self.isCompleted = isCompleted
        self.action = action
    }
    
    var body: some View {
        switch displayMode {
        case .summary:
            TreatmentSummaryView(treatmentModel) {
                action()
            }
            
        case .checkBoxView:
            TreatmentCheckBoxView(treatmentModel, isSelected: $isSelected){
                action()
            }
                
        case .completeBoxView:
            if let isCompleted = isCompleted {
                TreatmentCompleteBoxView(treatmentModel, isSelected: $isSelected, isCompleted: isCompleted) {
                     action()
                }
                   
            }
                
        }
    }
}

private struct TreatmentSummaryView: View {
    let treatmentModel: TreatmentModel
    let action: () -> Void
    
    init(_ treatmentModel: TreatmentModel, action: @escaping () -> Void) {
        self.treatmentModel = treatmentModel
        self.action = action
    }
    
    fileprivate var body: some View {
        HStack(spacing: 0) {
            Text(treatmentModel.name)
                .typography(.body1_r_14)
                .foregroundStyle(.gray800)
            Spacer()
                .frame(width: 12)
            Text("|")
                .font(.pretendard(.regular, size: 13))
                .foregroundStyle(.gray600)
            Spacer()
                .frame(width: 12)
            Text("다운타임*\(treatmentModel.downtimeMin)-\(treatmentModel.downtimeMax)일")
                .typography(.body1_r_14)
                .foregroundStyle(.gray700)
            Spacer()
            Image(.deletebox)
                .onTapGesture {
                    action()
                }
        }
        .padding(.leading, 17)
        .padding(.trailing,10)
        .padding(.vertical, 7)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(.gray200)
        )
    }
}

private struct TreatmentCheckBoxView: View {
    let treatmentModel: TreatmentModel
    @Binding var isSelected: Bool
    let action: () -> Void
    
    init(_ treatmentModel: TreatmentModel, isSelected: Binding<Bool>, action: @escaping () -> Void) {
        self.treatmentModel = treatmentModel
        self._isSelected = isSelected
        self.action = action
    }
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text(treatmentModel.name)
                    .typography(.title1_sb_18)
                Spacer()
            }
            HStack(spacing: 0) {
                Text(treatmentModel.benefits.joinedWithSeparator())
                    .typography(.body3_r_12)
                    .foregroundStyle(.gray700)
                Spacer()
            }
            
            
            Spacer()
            HStack(spacing: 0){
                Spacer()
                Image(.clock)
                    .foregroundStyle(.gray700)
                Text("다운타임*\(treatmentModel.downtimeMin)-\(treatmentModel.downtimeMax)일")
                    .font(.pretendard(.medium, size: 13))
                    .foregroundStyle(.gray700)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .frame(height: 100)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(isSelected ? .gray300 : Color.white)
        }
        .overlay{
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray500, lineWidth: 1)
        }
        .onTapGesture {
            action()
            isSelected.toggle()
        }
    }
}

private struct TreatmentCompleteBoxView: View {
    let treatmentModel: TreatmentModel
    @Binding var isSelected: Bool
    @Binding var isCompleted: Bool
    let action: () -> Void
    init(_ treatmentModel: TreatmentModel, isSelected: Binding<Bool>, isCompleted: Binding<Bool>, action: @escaping () -> Void) {
        self.treatmentModel = treatmentModel
        self._isSelected = isSelected
        self._isCompleted = isCompleted
        self.action = action
    }
    fileprivate var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(treatmentModel.name)
                    .typography(.title1_sb_18)
                Spacer()
                Image(isCompleted ? .checkCircular : .checkCircularGray)
                    
            }
            HStack(spacing: 0) {
                Text(treatmentModel.benefits.joinedWithSeparator())
                    .typography(.body3_r_12)
                    .foregroundStyle(.gray700)
                Spacer()
            }
            
            
            Spacer()
            HStack(spacing: 0){
                Spacer()
                Image(.clock)
                    .foregroundStyle(.gray700)
                Text("다운타임*\(treatmentModel.downtimeMin)-\(treatmentModel.downtimeMax)일")
                    .font(.pretendard(.medium, size: 13))
                    .foregroundStyle(.gray700)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .frame(height: 100)
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



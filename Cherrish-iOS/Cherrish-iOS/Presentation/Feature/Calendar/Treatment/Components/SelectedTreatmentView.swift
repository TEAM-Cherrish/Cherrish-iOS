//
//  SelectedTreatmentView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import SwiftUI

struct SelectedTreatmentView: View {
    @ObservedObject var viewModel: NoTreatmentViewModel
    
    private let itemHeight: CGFloat = 34.adjustedH
    private let spacing: CGFloat = 16.adjustedH
    private let maxVisibleCount = 3
    
    private var scrollViewHeight: CGFloat {
        let count = min(viewModel.selectedTreatments.count, maxVisibleCount)
        let contentHeight = CGFloat(count) * itemHeight + CGFloat(max(count - 1, 0)) * spacing
        return contentHeight + 24.adjustedH
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    TypographyText("선택한 시술", style: .body1_sb_14, color: .gray600)
                    
                    Spacer()
                    
                }
                .padding(.horizontal, 26.adjustedW)
                .padding(.vertical, 9.adjustedH)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray400)
                
            }
            .background(.gray0)
            .cornerRadius(10, corners: [.topLeft, .topRight])
            .shadow(
                color: .gray500.opacity(0.12),
                radius: 5,
                x: 0,
                y: -5
            )
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: spacing) {
                    ForEach(viewModel.selectedTreatments, id: \.id) { treatment in
                        TreatmentRowView(
                            displayMode: .summary,
                            treatmentEntity: treatment,
                            isSelected: .constant(true),
                            action: { viewModel.removeTreatment(treatment) }
                        )
                        .frame(height: itemHeight)
                    }
                }
                .padding(.vertical, 14.adjustedH)
            }
            .frame(height: scrollViewHeight)
            .scrollDisabled(viewModel.selectedTreatments.count <= maxVisibleCount)
            .padding(.horizontal, 24.5.adjustedW)
        }
    }
}


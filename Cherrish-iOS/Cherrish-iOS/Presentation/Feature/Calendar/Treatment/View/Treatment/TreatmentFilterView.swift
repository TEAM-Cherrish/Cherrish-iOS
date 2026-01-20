//
//  TreatmentFilterView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import SwiftUI

struct TreatmentFilterView: View {
    @ObservedObject var viewModel: TreatmentViewModel
    var body: some View {
        VStack {
            TreatmentSearchBarTextField(
                text: $viewModel.searchText,
                onTap: {
                    Task {
                        await viewModel.fetchTreatments()
                    }
                },
                isDisabled: false
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                HStack(alignment: .top,spacing: 4) {
                    TypographyText("◎", style: .body3_r_12, color: .gray600)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        TypographyText(
                            "본 정보는 인터넷 빅테이터 검색 및 분석을 통해 수집된 정보이며,공식적인 의료 정보가 아닙니다. ",
                            style: .body3_r_12,
                            color: .gray600
                        )
                        .lineLimit(2)
                        
                    }
                    
                    Spacer()
                    
                }
                .frame(height: 34.adjustedH)
                ForEach(viewModel.treatments, id: \.id) { treatment in
                    TreatmentRowView(
                        displayMode: .checkBoxView,
                        treatmentEntity: treatment,
                        isSelected: .constant(viewModel.isSelected(treatment)),
                        action: { viewModel.addTreatment(treatment) }
                    )
                }
            }
            
        }
        .task {
            await viewModel.fetchTreatments()
        }
        .padding(.horizontal, 24.5.adjustedW)
    }
}

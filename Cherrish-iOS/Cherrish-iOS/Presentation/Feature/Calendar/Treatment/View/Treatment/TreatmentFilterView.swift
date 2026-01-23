//
//  TreatmentFilterView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import SwiftUI

struct TreatmentFilterView: View {
    @ObservedObject var viewModel: TreatmentViewModel
    
    private let itemHeight: CGFloat = 34.adjustedH
    private let spacing: CGFloat = 8.adjustedH
    private let maxVisibleCount = 3
    
    private var scrollViewHeight: CGFloat {
        let count = min(viewModel.selectedTreatments.count, maxVisibleCount)
        let contentHeight = CGFloat(count) * itemHeight + CGFloat(max(count - 1, 0)) * spacing
        return contentHeight + 24.adjustedH + 40.adjustedH
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TreatmentSearchBarTextField(
                text: $viewModel.searchText,
                onTap: {
                    Task {
                        try await viewModel.fetchTreatments()
                    }
                    self.hideKeyboard()
                },
                isDisabled: false
            )
            .padding(.horizontal, 25.adjustedW)
            Spacer()
                .frame(height: 8.adjustedH)
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
                .padding(.horizontal, 25.adjustedW)
                if viewModel.isLoading {
                    CherrishLoadingView()
                } else {
                    if viewModel.treatments.isEmpty {
                        Spacer()
                            .frame(height: 148.adjustedH)
                        filterEmptyView
                    } else {
                        ForEach(viewModel.treatments, id: \.id) { treatment in
                            TreatmentRowView(
                                displayMode: .checkBoxView,
                                treatmentEntity: treatment,
                                isSelected: .constant(viewModel.isSelected(treatment)),
                                action: {  if viewModel.isSelected(treatment) {
                                    viewModel.removeTreatment(treatment)
                                } else {
                                    viewModel.addTreatment(treatment)
                                    
                                } }
                            )
                        }
                        .padding(.horizontal, 24.adjustedW)
                    }
                    Spacer()
                        .frame(
                                                height: viewModel.selectedTreatments.isEmpty ?
                                                24.adjustedH : scrollViewHeight.adjustedH + 24.adjustedH
                                            )
                }
            }
            
        }
        .task {
            Task {
                try await viewModel.fetchTreatments()
            }
        }
        
    }
}

extension TreatmentFilterView {
    
    private var filterEmptyView: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(.illustrationNosearch)
            Spacer()
                .frame(height: 16.adjustedH)
            VStack(alignment: .center, spacing: 0) {
                TypographyText("찾으시는 시술이 없습니다.", style: .body1_r_14, color: .gray600)
                TypographyText("다른 시술명을 입력해보세요.", style: .body1_r_14, color: .gray600)
            }
            .frame(height: 40.adjustedH)
        }
    }
}

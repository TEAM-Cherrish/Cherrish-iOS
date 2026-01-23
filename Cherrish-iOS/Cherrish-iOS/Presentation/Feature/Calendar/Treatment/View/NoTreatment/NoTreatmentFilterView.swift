//
//  NoTreatmentFilterView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import SwiftUI

struct NoTreatmentFilterView: View {
    @ObservedObject var viewModel: NoTreatmentViewModel
    
    
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
            TitleHeaderView(title: viewModel.selectedCategory?.title ?? "")
            if viewModel.isLoading {
                CherrishLoadingView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    Spacer()
                        .frame(height: 18.adjustedH)
                    
                    ForEach(viewModel.treatments, id: \.id) { treatment in
                        TreatmentRowView(
                            displayMode: .checkBoxView,
                            treatmentEntity: treatment,
                            isSelected: .constant(viewModel.isSelected(treatment)),
                            action: {
                                if viewModel.isSelected(treatment) {
                                    viewModel.removeTreatment(treatment)
                                } else {
                                    viewModel.addTreatment(treatment)
                                    
                                }
                            }
                        )
                        .padding(.horizontal, 25.adjustedW)
                        
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
            await viewModel.fetchNoTreatments()
        }
    }
}

private struct TitleHeaderView: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 4.adjustedH) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 6.adjustedW) {
                    TypographyText(title, style: .title1_sb_18, color: .gray1000)
                        .frame(height: 27.adjustedH)
                    TypographyText("관련 시술 리스트", style: .title1_sb_18, color: .gray1000)
                        .frame(height: 27.adjustedH)
                    Spacer()
                    
                }
                
                
                HStack(spacing: 4.adjustedW) {
                    VStack {
                        TypographyText("◎", style: .body3_r_12, color: .gray600)
                            .frame(height: 17.adjustedH)
                        Spacer()
                        
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        TypographyText("본 정보는 인터넷 빅테이터 검색 및 분석을 통해 수집된 정보이며, ", style: .body3_r_12, color: .gray600)
                            .frame(height: 17.adjustedH)
                        TypographyText("공식적인 의료 정보가 아닙니다.", style: .body3_r_12, color: .gray600)
                            .frame(height: 17.adjustedH)
                    }
                }
            }
            .padding(.horizontal, 25.adjustedW)
            .padding(.vertical, 20.adjustedH)
            
        }
        .background(Color.gray100)
        .overlay(alignment: .top) {
            Rectangle()
                .frame(height: 1.adjustedH)
                .gray500()
        }
        .overlay(alignment: .bottom) {
            Rectangle()
                .frame(height: 1.adjustedH)
                .gray500()
        }
        .frame(height: 105.adjustedH    )
        
    }
}

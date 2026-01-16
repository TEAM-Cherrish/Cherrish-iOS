//
//  NoTreatmentFilterView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import SwiftUI

struct NoTreatmentFilterView: View {
    
    @ObservedObject var viewModel: NoTreatmentViewModel
    var body: some View {
        VStack(spacing: 0) {
            TitleHeaderView(title: viewModel.treatmentCatagory?.title ?? "")
            Spacer()
                .frame(height: 10.adjustedH)
            ScrollView(.vertical, showsIndicators: false){
                Spacer()
                    .frame(height: 10.adjustedH)
                ForEach(viewModel.Treatments, id: \.id) { treatment in
                    TreatmentRowView(
                        displayMode: .checkBoxView,
                        treatmentEntity: treatment,
                        isSelected: .constant(viewModel.isSelected(treatment)),
                        action: { viewModel.addTreatment(treatment) }
                    )
                    .padding(.leading, 34.adjustedW)
                    .padding(.trailing, 33.adjustedW)
                }
            }
        }
    }
}

private struct TitleHeaderView: View {
    let title: String
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(spacing: 6) {
                    TypographyText(title, style: .title1_sb_18, color: .gray1000)
                    TypographyText("관련 시술 리스트", style: .title1_sb_18, color: .gray1000)
                    Spacer()
                }
                HStack(spacing: 4) {
                    VStack {
                        TypographyText("◎", style: .body3_r_12, color: .gray600)
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        TypographyText("본 정보는 인터넷 빅테이터 검색 및 분석을 통해 수집된 정보이며, ", style: .body3_r_12, color: .gray600)
                        TypographyText("관련 시술 리스트", style: .body3_r_12, color: .gray600)
                        Spacer()
                    }
                }
            }
            .padding(.leading, 25.adjustedW)
            .padding(.vertical, 20.adjustedH)
            Spacer()
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
        .frame(height: 105)
          
    }
}


#Preview {
    NoTreatmentView()
}

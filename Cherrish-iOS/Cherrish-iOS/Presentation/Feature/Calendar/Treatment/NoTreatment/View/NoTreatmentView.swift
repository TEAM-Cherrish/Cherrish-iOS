//
//  NoTreatmentView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/15/26.
//

import SwiftUI

struct NoTreatmentView: View {
    @StateObject private var viewModel: NoTreatmentViewModel
    
    init(viewModel: NoTreatmentViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        VStack {
            CherrishNavigationBar(
                title:viewModel.state.title,
                leftButtonAction: {
                    viewModel.previous()
                },
                rightButtonAction: {
                    
                }
            )
            ProgressBar(
                totalSteps: NoTreatment.allCases.count,
                currentStep: .constant(viewModel.step)
            )
            .padding( .horizontal, 33.5.adjustedW)
            .padding(.bottom, 20)
            VStack(spacing: 0){
                Group {
                    switch viewModel.state {
                    case .treatmentSelectedCategory:
                        TreatmentSelectedCategory(viewModel: viewModel)
                            .padding( .leading, 34.adjustedW)
                            .padding( .trailing, 33.adjustedW)
                            .id(viewModel.state)
                    case .targetDdaySetting:
                        TargetDdaySettingView(dDayState: $viewModel.dDay, year: $viewModel.year, month: $viewModel.month, day: $viewModel.day)
                            .padding( .leading, 34.adjustedW)
                            .padding( .trailing, 33.adjustedW)
                            .id(viewModel.state)
                    case .treatmentFilter:
                        NoTreatmentFilterView(viewModel: viewModel)
                        
                    case .downTimeSetting:
                        //TODO: 다운타임 설정
                        EmptyView()
                    }
                }
                Spacer()
                Group {
                    if viewModel.state == .treatmentFilter {
                        if !viewModel.selectedTreatments.isEmpty {
                            SelectedTreatmentView(viewModel: viewModel)
                        }
                    }
                    CherrishButton(title: "다음", type: .next, state: .constant(viewModel.canProceed ? .active : .normal)) {
                        viewModel.next()
                    }
                    .padding(.horizontal, 25.adjustedW)
                }
                Spacer()
                    .frame(height: 38.adjustedH)
            }
            .id(viewModel.step)
        }
        .ignoresSafeArea(.keyboard)
    }
}

//MARK: - TreatmentSelectedCategoryView

private struct TreatmentSelectedCategory: View {
    @ObservedObject var viewModel: NoTreatmentViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 50.adjustedH)
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    TypographyText(
                        "요즘 가장 신경 쓰이는 ",
                        style: .title1_sb_18,
                        color: .gray1000
                    )
                    TypographyText(
                        "피부 고민은 무엇인가요?",
                        style: .title1_sb_18,
                        color: .gray1000
                    )
                    TypographyText(
                        "선택한 고민을 기준으로 시술 정보를 정리해줘요.",
                        style: .body1_m_14,
                        color: .gray700
                    )
                }
                Spacer()
            }
            Spacer()
                .frame(height: 40.adjustedH)
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(TreatmentCategory.allCases, id: \.id) { catagory in
                    SelectionChip(
                        title: catagory.title,
                        isSelected: Binding(
                            get: {
                                viewModel.treatmentCatagory == catagory
                            },
                            set: {
                                isSelected in
                                guard isSelected else {
                                    return
                                }
                                viewModel.treatmentCatagory = catagory
                            }
                        )
                    )
                    
                }
            }
        }
    }
}

#Preview {
    NoTreatmentView(viewModel: NoTreatmentViewModel())
}

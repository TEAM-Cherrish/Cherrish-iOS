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
        VStack(spacing: 0) {
            CherrishNavigationBar(
                title:viewModel.state.title,
                leftButtonAction: {
                    viewModel.previous()
                },
                rightButtonAction: {
                    
                }
            )
            Spacer()
                .frame(height: 20.adjustedH)
            ProgressBar(
                totalSteps: NoTreatment.allCases.count,
                currentStep: .constant(viewModel.step)
            )
            .padding(.leading, 34.adjustedW)
            .padding(.trailing, 33.adjustedW)
            .padding(.bottom, 20.adjustedH)
            
            VStack(spacing: 0){
                Group {
                    switch viewModel.state {
                    case .treatmentSelectedCategory:
                        TreatmentSelectedCategory(viewModel: viewModel)
                            .id(viewModel.state)
                    case .targetDdaySetting:
                        TargetDdaySettingView(dDayState: $viewModel.dDay, year: $viewModel.year, month: $viewModel.month, day: $viewModel.day)
                            .id(viewModel.state)
                    case .treatmentFilter:
                        //TODO: 시술 필터링
                        EmptyView()
                    case .downTimeSetting:
                        //TODO: 다운타임 설정
                        EmptyView()
                    }
                }
                .padding( .leading, 34.adjustedW)
                .padding( .trailing, 33.adjustedW)
                
                Spacer()
                
                CherrishButton(title: "다음", type: .next, state: .constant(viewModel.canProceed ? .active : .normal)) {
                    viewModel.next()
                        
                }
                .padding(.leading, 25.adjustedW)
                .padding(.trailing, 24.adjustedW)
                
                Spacer()
                    .frame(height: 38.adjustedH)
            }
            .id(viewModel.step)
        }
        .ignoresSafeArea(.keyboard)
    }
}

private struct TreatmentSelectedCategory: View {
    @ObservedObject var viewModel: NoTreatmentViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 0) {
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
                .frame(height: 78.adjustedH)
                Spacer()
            }
            Spacer()
                .frame(height: 40.adjustedH)
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(TreatmentCategory.allCases, id: \.id) { category in
                    SelectionChip(
                        title: category.title,
                        isSelected: Binding(
                            get: {
                                viewModel.treatmentCatagory == category
                            },
                            set: {
                                isSelected in
                                guard isSelected else {
                                    return
                                }
                                viewModel.treatmentCatagory = category
                            }
                        )
                    )
                }
            }
        }
    }
}

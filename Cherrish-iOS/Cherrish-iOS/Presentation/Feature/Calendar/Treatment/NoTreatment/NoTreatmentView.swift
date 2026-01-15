//
//  NoTreatmentView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/15/26.
//

import SwiftUI

struct NoTreatmentView: View {
    @StateObject private var viewModel = NoTreatmentViewModel()
    var body: some View {
        
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
            currentStep: $viewModel.step
        )
        .padding( .horizontal, 33.5.adjustedW)
        
        VStack {
            
            switch viewModel.state {
            case .tretmentSelectedCatagory:
                TreatmentSelectedCatagory(viewModel: viewModel)
            case .targetDdaySetting:
                //TODO: 목표 디데이 설정
                TargetDdaySettingView(dDayState: $viewModel.dDay, year: $viewModel.year, month: $viewModel.month, day: $viewModel.day)
                
            case .treatmentfilter:
                //TODO: 시술 필터링
                EmptyView()
            case .downTimeSetting:
                //TODO: 다운타임 설정
                EmptyView()
            }
            Spacer()
            
            switch viewModel.state {
            case .tretmentSelectedCatagory:
                CherrishButton(title: "다음", type: .next, state: .constant(viewModel.treatmentCatagory == nil ? .normal : .active)) {
                    viewModel.next()
                }
            case .targetDdaySetting:
                CherrishButton(title: "다음", type: .next, state: .constant(.normal)) {
                    viewModel.next()
                }
            case .treatmentfilter:
                CherrishButton(title: "다음", type: .next, state: .constant(.normal)) {
                    
                }
            case .downTimeSetting:
                CherrishButton(title: "다음", type: .next, state: .constant(.normal)) {
                    
                }
            }
           
        }
        .padding( .leading, 34.adjustedW)
        .padding( .trailing, 33.adjustedW)
    }
}

private struct TreatmentSelectedCatagory: View {
    @ObservedObject var viewModel: NoTreatmentViewModel
    let columns = [
        GridItem(.flexible()),
            GridItem(.flexible())
        ]
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 70.adjustedH)
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0,) {
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
                .frame(
                    height: 40.adjustedH
                )
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(
                    TreatmentCatagory.allCases,
                    id: \.self
                ) { catagory in
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
    NoTreatmentView()
}

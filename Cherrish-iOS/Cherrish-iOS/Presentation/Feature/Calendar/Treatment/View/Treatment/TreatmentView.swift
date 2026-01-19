//
//  TreatmentView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import SwiftUI

struct TreatmentView: View {
    @ObservedObject var viewModel: TreatmentViewModel
    
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
                totalSteps: TreatmentStep.allCases.count,
                currentStep: .constant(viewModel.step)
            )
            .padding(.horizontal, 33.5.adjustedW)
            
            VStack(spacing: 0){
                Group {
                    switch viewModel.state {
                    case .targetDdaySetting:
                        TargetDdaySettingView(dDayState: $viewModel.dDay, year: $viewModel.year, month: $viewModel.month, day: $viewModel.day)
                            .padding(.horizontal, 34.adjustedW)
                            .id(viewModel.state)
                    case .treatmentFilter:
                        TreatmentFilterView(viewModel: viewModel)
                    case .downTimeSetting:
                        DownTimeSettingView(treatments: viewModel.selectedTreatments)
                    }
                }
                
                Spacer()
                
                Group {
                    if viewModel.state == .treatmentFilter {
                        if !viewModel.selectedTreatments.isEmpty {
                            SelectedTreatmentSheetView(selectedTreatments: viewModel.selectedTreatments, removeTreatment: viewModel.removeTreatment(_:))
                        }
                    }
                    
                    CherrishButton(
                        title: "다음",
                        type: .large,
                        state: .constant(viewModel.canProceed ? .active : .normal),
                        leadingIcon: nil,
                        trailingIcon: nil
                    ) {
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

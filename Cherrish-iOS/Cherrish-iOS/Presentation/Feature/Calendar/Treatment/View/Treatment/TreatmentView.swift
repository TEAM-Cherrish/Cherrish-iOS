//
//  TreatmentView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import SwiftUI

struct TreatmentView: View {
    @EnvironmentObject private var calendarCoordinator: CalendarCoordinator
    @EnvironmentObject private var tabBarCoordinator: TabBarCoordinator
    @ObservedObject var viewModel: TreatmentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            CherrishNavigationBar(
                title: viewModel.state.title,
                leftButtonAction: {
                    if viewModel.step == 1 {
                        calendarCoordinator.pop()
                    }
                    viewModel.previous()
                },
                rightButtonAction: {
                    calendarCoordinator.popToRoot()
                    tabBarCoordinator.isTabbarHidden = false
                }
            )
            
            Spacer()
                .frame(height: 20.adjustedH)
            
            ProgressBar(
                totalSteps: TreatmentStep.allCases.count,
                currentStep: .constant(viewModel.step)
            )
            .padding(.horizontal, 33.5.adjustedW)
            
            VStack(spacing: 0) {
                contentView()
                Spacer()
                bottomView()
                Spacer()
                    .frame(height: 38.adjustedH)
            }
            .id(viewModel.step)
        }
        .ignoresSafeArea(.keyboard,edges: .bottom)
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            tabBarCoordinator.isTabbarHidden = true
        }
    }
    
    @ViewBuilder
    private func contentView() -> some View {
        switch viewModel.state {
        case .targetDdaySetting:
            TargetDdaySettingView(
                dDayState: $viewModel.dDay,
                year: $viewModel.year,
                month: $viewModel.month,
                day: $viewModel.day
            )
            .padding(.leading, 34.adjustedW)
            .padding(.trailing, 33.adjustedW)
            .id(String(describing: viewModel.state))
            
        case .treatmentFilter:
            TreatmentFilterView(viewModel: viewModel)
            
        case .downTimeSetting:
            DownTimeSettingView(
                treatments: viewModel.selectedTreatments,
                setday: (
                    viewModel.toInt(
                        viewModel.year
                    ),
                    viewModel.toInt(
                        viewModel.month
                    ),
                    viewModel.toInt(
                        viewModel.day
                    )
                ),
                today: viewModel.today
            )
        }
    }
    
    @ViewBuilder
    private func bottomView() -> some View {
        VStack(spacing: 0) {
            if viewModel.state == .treatmentFilter, !viewModel.selectedTreatments.isEmpty {
                SelectedTreatmentSheetView(
                    selectedTreatments: viewModel.selectedTreatments,
                    removeTreatment: viewModel.removeTreatment(_:)
                )
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
    }
}

//
//  NoTreatmentView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/15/26.
//

import SwiftUI

struct NoTreatmentView: View {
    @EnvironmentObject private var calendarCoordinator: CalendarCoordinator
    @EnvironmentObject private var tabBarCoordinator: TabBarCoordinator
    @StateObject var viewModel: NoTreatmentViewModel
    
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
                totalSteps: NoTreatmentStep.allCases.count,
                currentStep: .constant(viewModel.step)
            )
            .padding(.horizontal, 34.adjustedW)
            .padding(.bottom, 20.adjustedH)
            
            VStack(spacing: 0) {
                contentView()
                Spacer()
                bottomView()
                Spacer()
                    .frame(height: 38.adjustedH)
            }
            .id(viewModel.step)
        }
        .ignoresSafeArea(.keyboard)
        .task {
            await viewModel.fetchCategories()
        }
        .onAppear {
            tabBarCoordinator.isTabbarHidden = true
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    @ViewBuilder
    private func contentView() -> some View {
        switch viewModel.state {
        case .treatmentSelectedCategory:
            TreatmentSelectedCategory(viewModel: viewModel)
                .id(String(describing: viewModel.state))
            
        case .targetDdaySetting:
            TargetDdaySettingView(
                dDayState: $viewModel.dDay,
                year: $viewModel.year,
                month: $viewModel.month,
                day: $viewModel.day
            )
            .id(String(describing: viewModel.state))
            
        case .treatmentFilter:
            NoTreatmentFilterView(viewModel: viewModel)
            
        case .downTimeSetting:
            DownTimeSettingView(
                treatments: $viewModel.selectedTreatments,
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
                ), today: viewModel.today
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
                if viewModel.state == .downTimeSetting {
                    Task {
                        do {
                            try await viewModel.createUserProcedure()
                        } catch {
                            CherrishLogger.error(error)
                        }
                      
                        tabBarCoordinator.isTabbarHidden = false
                        calendarCoordinator.popToRoot()
                    }
                } else {
                    viewModel.next()
                }
            }
            .padding(.horizontal, 25.adjustedW)
        }
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
                        "외모 고민은 무엇인가요?",
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
            .padding(.horizontal, 34.adjustedW)
            Spacer()
                .frame(height: 40.adjustedH)
            ScrollView(.vertical, showsIndicators:false) {
                LazyVGrid(columns: columns, spacing: 12.adjustedH) {
                    ForEach(viewModel.categories, id: \.id) { category in
                        SelectionChip(
                            title: category.title,
                            isSelected: Binding(
                                get: {
                                    viewModel.selectedCategory == category
                                },
                                set: {
                                    isSelected in
                                    guard isSelected else {
                                        return
                                    }
                                    viewModel.selectCategory(category)
                                }
                            )
                        )
                    }
                } .padding(.horizontal, 34.adjustedW)
            }
        }
    }
}


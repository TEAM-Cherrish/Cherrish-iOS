//
//  SelectTreatmentView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/15/26.
//

import SwiftUI

struct SelectTreatmentView: View {
    @EnvironmentObject private var calendarCoordinator: CalendarCoordinator
    @EnvironmentObject private var tabBarCoordinator: TabBarCoordinator
    @StateObject private var viewModel = SelectTreatmentViewModel()
    
    var body: some View {
        CherrishNavigationBar(
            title: "시술 여부 선택",
            leftButtonAction: {
                calendarCoordinator.pop()
                tabBarCoordinator.isTabbarHidden = false
            },
            rightButtonAction: {
                tabBarCoordinator.isTabbarHidden = false
                calendarCoordinator.popToRoot()
            }
        )
        VStack {
            Spacer()
                .frame(height: 94.adjustedH)
            TitleView()
            Spacer()
                .frame(height: 40.adjustedH)
            SelectChipsView(viewModel: viewModel)
            Spacer()
            CherrishButton(title: "다음", type: .next, state: $viewModel.buttonState, action: { })
            Spacer()
                .frame(height: 72.adjustedH)
        }
        .ignoresSafeArea()
        .padding(.leading, 34.adjustedW)
        .padding(.trailing, 33.adjustedW)
        
    }
}

private struct TitleView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                TypographyText("시술 일정을 추가해볼게요.", style: .title1_sb_18, color: .gray1000)
                TypographyText("이미 생각해둔 시술이 있나요?", style: .title1_sb_18, color: .gray1000)
                TypographyText("시술을 선택하셨는지 확인할게요.", style: .body1_r_14, color: .gray700)
            }
            Spacer()
        }
    }
}

private struct SelectChipsView: View {
    @ObservedObject var viewModel: SelectTreatmentViewModel
    
    var body: some View {
        HStack(
            spacing: 12
        ) {
            ForEach(TreatmentSelectionState.allCases, id: \.self) { state in
                SelectionChip(
                    title: state.title,
                    isSelected: Binding(
                        get: {
                            viewModel.treatmentSelectionState == state
                        },
                        set: { isSelected in
                            guard isSelected else {
                                return
                            }
                            viewModel.treatmentSelectionState = state
                            viewModel.buttonState = .active
                        }
                    )
                )
            }
        }
    }
}

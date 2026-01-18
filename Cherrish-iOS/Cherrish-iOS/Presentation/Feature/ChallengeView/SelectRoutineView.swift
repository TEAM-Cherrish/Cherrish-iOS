//
//  SelectRoutineView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/13/26.
//

import SwiftUI

struct SelectRoutineView: View {
    
    @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
    @EnvironmentObject private var tabBarCoordinator: TabBarCoordinator
    
    @StateObject private var viewModel = SelectRoutineViewModel()
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    
    var body: some View {
        VStack(spacing: 0) {
            CherrishNavigationBar(
                title: "루틴 챌린지 선택",
                leftButtonAction: {
                    challengeCoordinator.pop()
                    tabBarCoordinator.isTabbarHidden = false
                },
                rightButtonAction: {
                    challengeCoordinator.popToRoot()
                    tabBarCoordinator.isTabbarHidden = false
                }
            )
            HStack{
                VStack(alignment: .leading){
                    TypographyText("지금 나에게 가장 필요한\n관리 루틴을 선택해주세요.",
                        style: .title1_sb_18,
                        color: .gray1000
                    )
                }
                Spacer()
            }
            .padding(.top, 80.adjustedH)
            .padding(.horizontal, 33.adjustedW)
                        
            VStack(spacing: 12) {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.routines) { routine in
                        routineChip(routine)
                    }
                }
                .padding(.horizontal, 33.adjustedW)
                .padding(.top, 40.adjustedH)
            }
            
            Spacer()
            
            CherrishButton(title: "다음", type: .next, state: .constant(viewModel.nextButtonState)){
                challengeCoordinator.push(.loading)
                }
            .padding(.bottom, 38.adjustedH)
            .padding(.horizontal, 24.adjustedW)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

private extension SelectRoutineView {
    func routineChip(_ routine: RoutineType) -> some View {
        SelectionChip(
            title: routine.title,
            isSelected: Binding(
                get: {viewModel.selectedRoutine == routine},
                set: {isSelected in
                    guard isSelected else { return }
                    viewModel.select(routine)}
            )
        )
    }
}

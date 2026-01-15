//
//  SelectRoutineView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/13/26.
//

import SwiftUI

enum RoutineType{
    case skinCondition
    case lifeStyle
    case bodyShaping
    case wellness
    
    var title: String {
        switch self {
        case .skinCondition:
            return "피부 컨디션"
        case .lifeStyle:
            return "생활습관"
        case .bodyShaping:
            return "체형 관리"
        case .wellness:
            return "웰니스∙마음챙김"
        }
    }
}

struct SelectRoutineView: View {
    
    @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
    @EnvironmentObject private var tabBarCoordinator: TabBarCoordinator
    
    @State private var selectedRoutine: RoutineType? = nil
    
    private var nextButtonState: ButtonState {
        selectedRoutine == nil ? .normal : .active
    }
    
    var body: some View {
        VStack {
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
                HStack(spacing: 12) {
                    routineChip(type: .skinCondition)
                    routineChip(type: .lifeStyle)
                }
                HStack(spacing: 12) {
                    routineChip(type: .bodyShaping)
                    routineChip(type: .wellness)
                }
            }
            .padding(.horizontal, 33.adjustedW)
            .padding(.top, 40.adjustedH)
            
            Spacer()
            
            CherrishButton(title: "다음", type: .next, state: .constant(nextButtonState)){
                challengeCoordinator.push(.loading)
//                challengeCoordinator.push(.selectMission)
                }
            .padding(.bottom, 38.adjustedH)
            .padding(.horizontal, 24.adjustedW)
        }
    }
}

private extension SelectRoutineView {
    func routineChip(type: RoutineType) -> some View {
        SelectionChip(
            title: type.title,
            isSelected: Binding(get: {selectedRoutine == type},
                                set: {isSelected in
                                    guard isSelected else { return }
                                    selectedRoutine = type})
        )
    }
}

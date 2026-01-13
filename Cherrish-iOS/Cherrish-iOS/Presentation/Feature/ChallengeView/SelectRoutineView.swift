//
//  SelectRoutineView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/13/26.
//

import SwiftUI

import SwiftUI

enum RoutineType{
    case skinCondition
    case lifeStyle
    case bodyShaping
    case wellness
}

struct SelectRoutineView: View {
    
    @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
    
    @State private var selectedRoutine: RoutineType? = nil
    
    private var nextButtonState: ButtonState {
        selectedRoutine == nil ? .normal : .active
    }
    
    var body: some View {
        VStack() {
            CherrishNavigationBar(
                title: "루틴 챌린지 선택",
                leftButtonAction: challengeCoordinator.pop,
                rightButtonAction: challengeCoordinator.pop
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
                    routineChip(title: "피부 컨디션", type: .skinCondition)
                    routineChip(title: "생활습관", type: .lifeStyle)
                }
                HStack(spacing: 12) {
                    routineChip(title: "체형 관리", type: .bodyShaping)
                    routineChip(title: "웰니스∙마음챙김", type: .wellness)
                }
            }
            .padding(.horizontal, 33.adjustedW)
            .padding(.top, 40.adjustedH)
            
            Spacer()
            
            CherrishButton(title: "다음", type: .next, state: .constant(nextButtonState)){
                challengeCoordinator.push(.loading)
                }
            .padding(.bottom, 38.adjustedH)
            .padding(.horizontal, 24.adjustedW)
        }
    }
}

private extension SelectRoutineView {
    func routineChip(title: String, type: RoutineType) -> some View {
        SelectionChip(title: title, isSelected: Binding(get: {selectedRoutine == type},
                                                        set: {isSelected in selectedRoutine = isSelected ? type : nil}))
    }
}

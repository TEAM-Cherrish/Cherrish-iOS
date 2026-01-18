//
//  SelectRoutineViewModel.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/16/26.
//

import SwiftUI
import Combine

enum RoutineType: CaseIterable, Identifiable {
    case skinCondition
    case lifeStyle
    case bodyShaping
    case wellness
    
    var id: Self { self }
    
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

@MainActor
final class SelectRoutineViewModel: ObservableObject {
    
//    @Published var routines: [RoutineType] = []
    @Published var routines: [RoutineType] = RoutineType.allCases
    
    @Published var selectedRoutine: RoutineType? = nil
    
    var nextButtonState: ButtonState {
        selectedRoutine == nil ? .normal : .active
    }
    
    func select(_ routine: RoutineType) {
        selectedRoutine = routine
    }
}

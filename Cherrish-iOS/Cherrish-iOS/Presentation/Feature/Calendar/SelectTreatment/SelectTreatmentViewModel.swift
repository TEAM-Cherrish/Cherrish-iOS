//
//  SelectTreatmentViewModel.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/15/26.
//

import SwiftUI

enum TreatmentSelectionState: CaseIterable {
    case notSelected
    case available
    
    var title: String {
        switch self {
        case .notSelected:
            return "아직 선택 전이에요"
        case .available:
            return "선택한 시술이 있어요"
        }
    }
}

final class SelectTreatmentViewModel: ObservableObject {
    @Published var treatmentSelectionState: TreatmentSelectionState?
    @Published var buttonState: ButtonState = .normal
    
}


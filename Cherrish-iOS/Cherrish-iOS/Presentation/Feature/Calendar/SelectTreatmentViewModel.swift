//
//  SelectTreatmentViewModel.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/15/26.
//

import SwiftUI

enum TreatmentSelectionState {
    case notSelected
    case available
}
class SelectTreatmentViewModel: ObservableObject {
    @Published var treatmentSelectionState: TreatmentSelectionState?
    @Published var buttonState: ButtonState = .normal
    
}


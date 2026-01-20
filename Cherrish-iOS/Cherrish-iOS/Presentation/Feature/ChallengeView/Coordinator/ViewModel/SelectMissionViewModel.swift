//
//  SelectMissionViewModel.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/19/26.
//

import SwiftUI

final class SelectMissionViewModel: ObservableObject {
    
    @Published private(set) var missions: [ChallengeMissionEntity] = []
    @Published var selectedStates: [Bool]
    
    init(missions: [ChallengeMissionEntity]) {
        self.missions = missions
        self.selectedStates = Array(repeating: false, count: missions.count)
    }
    
    var isNextButtonEnabled: Bool {
        selectedStates.contains(true)
    }
    
    func toggleSelection(at index: Int) {
        guard selectedStates.indices.contains(index) else { return }
        selectedStates[index].toggle()
    }
    
    func selectedMissions() -> [ChallengeMissionEntity] {
        zip(missions, selectedStates)
            .filter { $0.1 }
            .map { $0.0 }
    }
}

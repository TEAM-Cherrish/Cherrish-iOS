//
//  SelectRoutineView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/13/26.
//

import SwiftUI

struct SelectRoutineView: View {
    @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
    
    var body: some View {
        ZStack {
            Color.red600
            
            VStack {
                Text("SelectRoutine")
                
                Button("next") {
                    challengeCoordinator.push(.loading)
                }
            }
        }
    }
}

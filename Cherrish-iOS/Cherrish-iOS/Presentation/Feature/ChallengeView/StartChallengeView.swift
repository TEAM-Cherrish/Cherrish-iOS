//
//  StartChallengeView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/10/26.
//

import SwiftUI

struct StartChallengeView: View {
    @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
    
    var body: some View {
        ZStack {
            Color.red600
            VStack {
                Text("StartChallenge")
                Button("next") {
                    challengeCoordinator.push(.selectMission)
                }
            }
        }
    }
}

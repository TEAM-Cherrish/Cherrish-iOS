//
//  ChallengeCoordinatorView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/10/26.
//

import SwiftUI

struct ChallengeCoordinatorView: View {
    @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
    
    var body: some View {
        NavigationStack(path: $challengeCoordinator.path) {
            ViewFactory.shared.makeStartChallengeView()
                .navigationDestination(for: ChallengeRoute.self) { route in
                    switch route {
                    case .root:
                        ViewFactory.shared.makeChallengeView()
                    case .startChallenge:
                        ViewFactory.shared.makeStartChallengeView()
                    case .selectMission:
                        ViewFactory.shared.makeSelectMissionView()
                    case .loading:
                        ViewFactory.shared.makeLoadingView()
                    }
                }
        }
    }
}

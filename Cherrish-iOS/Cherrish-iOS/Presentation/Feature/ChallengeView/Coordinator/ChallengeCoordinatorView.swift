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
                            .navigationBarBackButtonHidden()
                    case .startChallenge:
                        ViewFactory.shared.makeStartChallengeView()
                            .navigationBarBackButtonHidden()
                    case .selectRoutine:
                        ViewFactory.shared.makeSelectRoutineView()
                            .navigationBarBackButtonHidden()
                    case .loading:
                        ViewFactory.shared.makeLoadingView()
                            .navigationBarBackButtonHidden()
                    case .selectMission:
                        ViewFactory.shared.makeSelectMissionView()
                            .navigationBarBackButtonHidden()
                    }
                }
        }
        .ignoresSafeArea(.all)
    }
}

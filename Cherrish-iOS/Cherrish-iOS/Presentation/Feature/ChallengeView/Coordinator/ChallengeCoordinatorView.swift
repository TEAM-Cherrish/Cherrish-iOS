//
//  ChallengeCoordinatorView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/10/26.
//

import SwiftUI

struct ChallengeCoordinatorView: View {
    @EnvironmentObject private var challengeCoordinator: ChallengeCoordinator
    @EnvironmentObject private var tabBarCoordinator: TabBarCoordinator
    var body: some View {
        NavigationStack(path: $challengeCoordinator.path) {
            ViewFactory.shared.makeStartChallengeView()
                .navigationDestination(for: ChallengeRoute.self) { route in
                    Group {
                        switch route {
                        case .root:
                            ViewFactory.shared.makeChallengeView()
                        case .startChallenge:
                            ViewFactory.shared.makeStartChallengeView()
                        case .selectRoutine:
                            ViewFactory.shared.makeSelectRoutineView()
                                .onAppear() {
                                    tabBarCoordinator.isTabbarHidden = true
                                }
//                                .onDisappear {
//                                    tabBarCoordinator.isTabbarHidden = false
//                                }
                        case .loading:
                            ViewFactory.shared.makeLoadingView()
                                .onAppear() {
                                    tabBarCoordinator.isTabbarHidden = true
                                }
                        case .selectMission:
                            ViewFactory.shared.makeSelectMissionView()
                                .onAppear() {
                                    tabBarCoordinator.isTabbarHidden = true
                                }
                        case .challengeProgress:
                            ViewFactory.shared.makeChallengeProgressView()
                                .onAppear() {
                                    tabBarCoordinator.isTabbarHidden = false
                                }
                        }
                    }
                    .navigationBarBackButtonHidden()
                }
        }
    }
}

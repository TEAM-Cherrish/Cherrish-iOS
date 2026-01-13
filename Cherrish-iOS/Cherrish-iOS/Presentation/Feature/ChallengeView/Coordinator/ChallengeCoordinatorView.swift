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
                            .onAppear() {
                                tabBarCoordinator.isTabbarHidden = true
                            }
                    case .loading:
                        ViewFactory.shared.makeLoadingView()
                            .navigationBarBackButtonHidden()
                            .onAppear() {
                                tabBarCoordinator.isTabbarHidden = true
                            }
                    case .selectMission:
                        ViewFactory.shared.makeSelectMissionView()
                            .navigationBarBackButtonHidden()
                            .onAppear() {
                                tabBarCoordinator.isTabbarHidden = true
                            }
                    case .challengeProgress:
                        ViewFactory.shared.makeChallengeProgressView()
                            .navigationBarBackButtonHidden()
                            .onAppear() {
                                tabBarCoordinator.isTabbarHidden = false
                            }
                        
                    }
                }
        }
        .ignoresSafeArea(.all)
    }
}

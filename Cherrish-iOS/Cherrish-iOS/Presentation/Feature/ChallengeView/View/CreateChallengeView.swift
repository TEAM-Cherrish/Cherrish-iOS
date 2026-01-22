//
//  CreateChallengeView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/21/26.
//

import SwiftUI

struct CreateChallengeView: View {
    @EnvironmentObject var challengeCoordinator: ChallengeCoordinator
    @EnvironmentObject var tabBarCoordinator: TabBarCoordinator
    @StateObject var viewModel: CreateChallengeViewModel
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20.adjustedH)
            
            CherrishNavigationBar(
                isDisplayLeftButton: viewModel.viewState.isLeftButton,
                isDisplayRightButton: viewModel.viewState.isRightButton,
                title: viewModel.viewState.title,
                leftButtonAction: {
                    if viewModel.viewState == .routine {
                        tabBarCoordinator.isTabbarHidden = false
                        challengeCoordinator.popToRoot()
                    } else if viewModel.viewState == .mission {
                        
                        viewModel.viewState = .routine
                        
                    } else {
                        viewModel.previous()
                    }
                },
                rightButtonAction: {
                    tabBarCoordinator.isTabbarHidden = false
                    challengeCoordinator.popToRoot()
                }
            )
            switch viewModel.viewState {
            case .routine:
                ChallengeSelectRoutineView(viewModel: viewModel)
            case .loading:
                ChallengeLoadingView(viewModel: viewModel)
            case .mission:
                ChallengeSelectMissionView(viewModel: viewModel)
            }
        }
    }
}

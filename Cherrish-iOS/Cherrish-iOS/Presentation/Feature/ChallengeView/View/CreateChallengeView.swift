//
//  CreateChallengeView.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/21/26.
//

import SwiftUI

struct CreateChallengeView: View {
    @StateObject var viewModel: CreateChallengeViewModel
    
    var body: some View {
        VStack {
            CherrishNavigationBar(
                isDisplayLeftButton: true, isDisplayRightButton: true, title: viewModel.viewState.title, leftButtonAction: {}, rightButtonAction: {}
            )
            switch viewModel.viewState {
            case .routine:
                ChallengeSelectRoutineView(viewModel: viewModel)
            case .loding:
                ChallengeLoadingView()
            case .mission:
                ChallengeSelectMissionView(viewModel: viewModel)
            }
        }
    }
}


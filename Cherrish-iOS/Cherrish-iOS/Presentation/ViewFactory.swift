//
//  ViewFactory.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/5/26.
//

import Foundation

protocol ViewFactoryProtocol {
    func makeOnboardingView() -> OnboardingView
    func makeInformationView() -> InformationView
    func makeHomeView() -> HomeView
    func makeCalendarView() -> CalendarView
    func makeChallengeView() -> ChallengeView
    func makeMyPageView() -> MyPageView
    func makeSelectTreatmentView() -> SelectTreatmentView
    func makeStartChallengeView() -> StartChallengeView
    func makeSelectRoutineView() -> SelectRoutineView
    func makeSelectMissionView() -> SelectMissionView
    func makeLoadingView() -> LoadingView
    func makeChallengeProgressView() -> ChallengeProgressView
}

final class ViewFactory: ViewFactoryProtocol {
    static let shared = ViewFactory()
    
    func makeOnboardingView() -> OnboardingView {
        guard let viewModel = DIContainer.shared.resolve(type: OnboardingViewModel.self) else {
            fatalError()
        }
        return OnboardingView(viewModel: viewModel)
    }
    
    func makeInformationView() -> InformationView {
        guard let viewModel = DIContainer.shared.resolve(type: OnboardingViewModel.self) else {
            fatalError()
        }
        return InformationView(viewModel: viewModel)
    }
    
    func makeHomeView() -> HomeView {
        return HomeView()
    }
    
    func makeCalendarView() -> CalendarView {
        return CalendarView()
    }
    
    func makeChallengeView() -> ChallengeView {
        return ChallengeView()
    }
    
    func makeMyPageView() -> MyPageView {
        return MyPageView()
    }
    
    func makeSelectTreatmentView() -> SelectTreatmentView {
        return SelectTreatmentView()
    }
    
    func makeStartChallengeView() -> StartChallengeView {
        return StartChallengeView()
    }
    
    func makeSelectRoutineView() -> SelectRoutineView {
        return SelectRoutineView()
    }
    
    func makeSelectMissionView() -> SelectMissionView {
        return SelectMissionView()
    }
    
    func makeLoadingView() -> LoadingView {
        return LoadingView()
    }
    
    func makeChallengeProgressView() -> ChallengeProgressView {
        return ChallengeProgressView()
    }
}

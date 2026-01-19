//
//  ViewFactory.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/5/26.
//

import Foundation

protocol ViewFactoryProtocol {
    func makeOnboardingContainerView() -> OnboardingContainerView
    func makeInformationView() -> InformationView
    func makeHomeView() -> HomeView
    func makeNoTreatmentView() -> NoTreatmentView
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
    
    func makeOnboardingContainerView() -> OnboardingContainerView {
        guard let viewModel = DIContainer.shared.resolve(type: OnboardingViewModel.self) else {
            fatalError()
        }
        return OnboardingContainerView(viewModel: viewModel)
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
        guard let viewModel = DIContainer.shared.resolve(type: CalendarViewModel.self) else {
            fatalError()
        }
        return CalendarView(viewModel: viewModel)
    }
    
    func makeChallengeView() -> ChallengeView {
        return ChallengeView()
    }
    
    func makeMyPageView() -> MyPageView {
        return MyPageView()
    }
    
    func makeSelectTreatmentView() -> SelectTreatmentView {
        guard let viewModel = DIContainer.shared.resolve(type: SelectTreatmentViewModel.self) else {
            fatalError()
        }
        return SelectTreatmentView(viewModel: viewModel)
    }
    
    func makeNoTreatmentView() -> NoTreatmentView {
        guard let viewModel = DIContainer.shared.resolve(type: NoTreatmentViewModel.self) else {
            fatalError()
        }
        return NoTreatmentView(viewModel: viewModel)
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

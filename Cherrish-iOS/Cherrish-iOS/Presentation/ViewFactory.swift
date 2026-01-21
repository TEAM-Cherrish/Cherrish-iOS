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
    func makeTreatmentView() -> TreatmentView
    func makeCalendarView() -> CalendarView
    func makeMyPageView() -> MyPageView
    func makeSelectTreatmentView() -> SelectTreatmentView
    func makeStartChallengeView() -> ChallengeStartChallengeView
    func makeCreateChallengeView() -> CreateChallengeView
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
        guard let viewModel = DIContainer.shared.resolve(type: HomeViewModel.self) else {
            fatalError()
        }
        return HomeView(viewModel: viewModel)
    }
    
    func makeCalendarView() -> CalendarView {
        guard let viewModel = DIContainer.shared.resolve(type: CalendarViewModel.self),
              let homeCalendarFlowState = DIContainer.shared.resolve(type: HomeCalendarFlowState.self) else {
            fatalError()
        }
        return CalendarView(viewModel: viewModel, homeCalendarFlowState: homeCalendarFlowState)
    }
    
    func makeMyPageView() -> MyPageView {
        guard let viewModel = DIContainer.shared.resolve(type: MyPageViewModel.self) else {
            fatalError()
        }
        return MyPageView(viewModel: viewModel)
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
    
    func makeTreatmentView() -> TreatmentView {
        guard let viewModel = DIContainer.shared.resolve(type: TreatmentViewModel.self) else {
            fatalError()
        }
        return TreatmentView(viewModel: viewModel)
    }
    
    func makeStartChallengeView() -> ChallengeStartChallengeView {
        return ChallengeStartChallengeView()
    }
    
    func makeCreateChallengeView() -> CreateChallengeView {
        guard let viewModel = DIContainer.shared.resolve(type: CreateChallengeViewModel.self) else {
            fatalError()
        }
        return CreateChallengeView(viewModel: viewModel)
    }

    func makeChallengeProgressView() -> ChallengeProgressView {
        guard let viewModel = DIContainer.shared.resolve(type: ChallengeProgressViewModel.self) else {
            fatalError()
        }
        return ChallengeProgressView(viewModel: viewModel)
    }
}

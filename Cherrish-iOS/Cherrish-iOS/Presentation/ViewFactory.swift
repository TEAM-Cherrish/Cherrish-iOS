//
//  ViewFactory.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/5/26.
//

import Foundation

protocol ViewFactoryProtocol {
    func makeOnboardingView() -> OnboardingView
    func makeHomeView() -> HomeView
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
}

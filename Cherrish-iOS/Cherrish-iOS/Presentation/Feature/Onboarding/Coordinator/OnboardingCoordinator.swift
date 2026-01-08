//
//  OnboardingCoordinator.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/8/26.
//

import SwiftUI

enum OnboardingRoute: PresentationTypeProtocol {
    case information
    case onboarding
}

final class OnboardingCoordinator: CoordinatorProtocol {
    typealias RouteView = OnboardingRoute
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var route: OnboardingRoute = .information
    
    func push(_ route: OnboardingRoute) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}

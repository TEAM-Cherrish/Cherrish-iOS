//
//  AppCoordinator.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/8/26.
//

import Foundation
import SwiftUI

enum AppState {
    case onboarding
    case home
}

final class AppCoordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Published var appState: AppState = .onboarding
    
    func navigationToTabbar() {
        path.removeLast(path.count)
        appState = .home
    }
    
    func navigationToOnboarding() {
        path.removeLast(path.count)
        appState = .onboarding
    }
}

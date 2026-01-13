//
//  ChallengeCoordinator.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/9/26.
//

import SwiftUI

enum ChallengeRoute: PresentationTypeProtocol {
    case root
    case startChallenge
    case selectRoutine
    case loading
    case selectMission
    case challengeProgress
}

final class ChallengeCoordinator: CoordinatorProtocol {
    typealias RouteView = ChallengeRoute
    
    @Published var path: NavigationPath = NavigationPath()
    
    func push(_ route: ChallengeRoute) {
        path.append(route)
    }
}

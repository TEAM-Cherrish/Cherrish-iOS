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
    case createChallenge
    case challengeProgress
}

final class ChallengeCoordinator: CoordinatorProtocol {
    typealias RouteView = ChallengeRoute
    
    @Published var path: NavigationPath = NavigationPath()

    var makeChallengeViewModel: CreateChallengeViewModel?
    
    func push(_ route: ChallengeRoute) {
        path.append(route)
    }
}

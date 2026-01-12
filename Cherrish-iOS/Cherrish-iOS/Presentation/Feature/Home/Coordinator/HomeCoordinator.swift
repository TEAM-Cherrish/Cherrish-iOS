//
//  HomeCoordinator.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/9/26.
//

import Foundation
import SwiftUI

enum HomeRoute: PresentationTypeProtocol {
    case root
}

final class HomeCoordinator: CoordinatorProtocol {
    typealias RouteView = HomeRoute
    
    @Published var path: NavigationPath = NavigationPath()
    
    func push(_ route: HomeRoute) {
        path.append(route)
    }
}

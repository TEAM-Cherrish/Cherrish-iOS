//
//  MyPageCoordinator.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/9/26.
//

import Foundation
import SwiftUI

enum MyPageRoute: PresentationTypeProtocol {
    case root
}

final class MyPageCoordinator: CoordinatorProtocol {
    typealias RouteView = MyPageRoute
    
    @Published var path: NavigationPath = NavigationPath()
    
    func push(_ route: MyPageRoute) {
        path.append(route)
    }
}

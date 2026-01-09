//
//  CalendarCoordinator.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/9/26.
//

import Foundation
import SwiftUI

enum CalendarRoute: PresentationTypeProtocol {
    case root
    case selectTreatment // TODO: 추후 수정
}

final class CalendarCoordinator: CoordinatorProtocol {
    typealias RouteView = CalendarRoute
    
    @Published var path = NavigationPath()
    
    func push(_ route: CalendarRoute) {
        path.append(route)
    }
}

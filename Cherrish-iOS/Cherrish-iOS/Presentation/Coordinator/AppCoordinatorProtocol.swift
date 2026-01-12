//
//  AppCoordinatorProtocol.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/8/26.
//

import Foundation
import SwiftUI

protocol CoordinatorProtocol: ObservableObject {
    associatedtype RouteView: PresentationTypeProtocol
    
    var path: NavigationPath { get set }
    
    func push(_ route: RouteView)
    func pop()
    func popToRoot()
}

extension CoordinatorProtocol {
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}

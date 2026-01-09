//
//  HomeCoordinatorView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/10/26.
//

import SwiftUI

struct HomeCoordinatorView: View {
    @EnvironmentObject private var homeCoordinator: HomeCoordinator
    
    var body: some View {
        NavigationStack(path: $homeCoordinator.path) {
            ViewFactory.shared.makeHomeView()
                .navigationDestination(for: HomeRoute.self) { route in
                    switch route {
                    case .root:
                        ViewFactory.shared.makeHomeView()
                    }
                }
        }
    }
}

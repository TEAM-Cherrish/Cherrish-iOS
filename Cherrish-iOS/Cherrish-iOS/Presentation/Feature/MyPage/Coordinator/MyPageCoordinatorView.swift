//
//  MyPageCoordinatorView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/10/26.
//

import SwiftUI

struct MyPageCoordinatorView: View {
    @EnvironmentObject private var myPageCoordinator: MyPageCoordinator
    
    var body: some View {
        NavigationStack {
            ViewFactory.shared.makeMyPageView()
                .navigationDestination(for: MyPageRoute.self) { route in
                    switch route {
                    case .root:
                        ViewFactory.shared.makeMyPageView()
                    }
            }
        }
    }
}

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
        NavigationStack(path: $myPageCoordinator.path) {
            ViewFactory.shared.makeMyPageView()
        }
    }
}

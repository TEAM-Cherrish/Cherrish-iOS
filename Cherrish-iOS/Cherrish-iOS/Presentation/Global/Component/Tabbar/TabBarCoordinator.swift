//
//  CherrishTabbarCoordinator.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/9/26.
//

import Foundation
import SwiftUI

enum CherrishTab: CaseIterable, Hashable {
    case home
    case calendar
    case challenge
    case mypage
}

final class TabBarCoordinator: ObservableObject {
    @Published var selectedTab: CherrishTab = .home
    @Published var isTabbarHidden: Bool = false
    
    lazy var homeCoordinator = HomeCoordinator()
    lazy var calendarCoordinator = CalendarCoordinator()
    lazy var challengeCoordinator = ChallengeCoordinator()
    lazy var mypageCoordinator = MyPageCoordinator()
    
    func switchTab(tab: CherrishTab) {
        selectedTab = tab
        isTabbarHidden = false
    }
}

//
//  TabbarCoordinatorView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/9/26.
//

import Foundation
import SwiftUI

struct TabBarCoordinatorView: View {
    @StateObject private var tabBarCoordinator = TabBarCoordinator()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group{
                switch tabBarCoordinator.selectedTab {
                case .home:
                    HomeCoordinatorView()
                        .environmentObject(tabBarCoordinator.homeCoordinator)
                case .calendar:
                    CalendarCoordinatorView()
                        .environmentObject(tabBarCoordinator.calendarCoordinator)
                case .challenge:
                    ChallengeCoordinatorView()
                        .environmentObject(tabBarCoordinator.challengeCoordinator)
                case .mypage:
                    MyPageCoordinatorView()
                        .environmentObject(tabBarCoordinator.mypageCoordinator)
                }
            }
            .padding(.bottom, tabBarCoordinator.isTabbarHidden ? 0 : 54.adjustedH)
            .id(tabBarCoordinator.selectedTab)
            if !tabBarCoordinator.isTabbarHidden {
                CherrishTabBar(selectedTab: $tabBarCoordinator.selectedTab)
            }
        }
        .environmentObject(tabBarCoordinator)
        .onChange(of: tabBarCoordinator.selectedTab) { _, newTab in
            switch newTab {
            case .home:
                tabBarCoordinator.homeCoordinator.popToRoot()
            case .calendar:
                tabBarCoordinator.calendarCoordinator.popToRoot()
            case .challenge:
                tabBarCoordinator.challengeCoordinator.popToRoot()
            case .mypage:
                tabBarCoordinator.mypageCoordinator.popToRoot()
            }
        }
    }
}

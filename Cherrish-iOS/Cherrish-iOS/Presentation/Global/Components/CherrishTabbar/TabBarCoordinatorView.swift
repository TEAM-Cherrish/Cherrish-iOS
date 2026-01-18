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
            TabView(selection: $tabBarCoordinator.selectedTab) {
                HomeCoordinatorView()
                    .tag(CherrishTab.home)
                    .environmentObject(tabBarCoordinator.homeCoordinator)
                
                CalendarCoordinatorView()
                    .tag(CherrishTab.calendar)
                    .environmentObject(tabBarCoordinator.calendarCoordinator)
                
                ChallengeCoordinatorView()
                    .tag(CherrishTab.challenge)
                    .environmentObject(tabBarCoordinator.challengeCoordinator)
                            
                MyPageCoordinatorView()
                    .tag(CherrishTab.mypage)
                    .environmentObject(tabBarCoordinator.mypageCoordinator)
            }
            
            if !tabBarCoordinator.isTabbarHidden {
                CherrishTabBar(selectedTab: $tabBarCoordinator.selectedTab)
            }
        }
        .environmentObject(tabBarCoordinator)
    }
}

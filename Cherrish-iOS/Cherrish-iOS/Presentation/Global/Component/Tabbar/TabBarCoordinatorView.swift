//
//  TabbarCoordinatorView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/9/26.
//

import Foundation
import SwiftUI

struct TabBarCoordinatorView: View {
    @EnvironmentObject private var tab: TabBarCoordinator
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $tab.selectedTab) {
                HomeCoordinatorView()
                    .tag(CherrishTab.home)
                    .environmentObject(tab.homeCoordinator)
                
                CalendarCoordinatorView()
                    .tag(CherrishTab.calendar)
                    .environmentObject(tab.calendarCoordinator)
                
                ChallengeCoordinatorView()
                    .tag(CherrishTab.challenge)
                    .environmentObject(tab.challengeCoordinator)
                            
                MyPageCoordinatorView()
                    .tag(CherrishTab.mypage)
                    .environmentObject(tab.mypageCoordinator)
            }
            
            if !tab.isTabbarHidden {
                CherrishTabBar(selectedTab: $tab.selectedTab)
            }
        }
    }
}

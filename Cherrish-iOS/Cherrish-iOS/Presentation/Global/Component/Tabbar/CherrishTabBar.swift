//
//  CherrishTabbar.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/8/26.
//

import SwiftUI

extension CherrishTab {
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .calendar:
            return "캘린더"
        case .challenge:
            return "챌린지"
        case .mypage:
            return "마이"
        }
    }
    
    var defaultIcon: ImageResource {
        switch self {
        case .home:
            return .homeDef
        case .calendar:
            return .calendarDef
        case .challenge:
            return .challengeDef
        case .mypage:
            return .myDef
        }
    }
    
    var selectedIcon: ImageResource {
        switch self {
        case .home:
            return .homeAct
        case .calendar:
            return .calendarAct
        case .challenge:
            return .challengeAct
        case .mypage:
            return .myAct
        }
    }
}

struct CherrishTabBar: View {
    @Binding var selectedTab: CherrishTab
    
    var body: some View {
        HStack {
            ForEach(CherrishTab.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    VStack(alignment: .center, spacing: 3) {
                        Image(selectedTab == tab ? tab.selectedIcon : tab.defaultIcon)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(tab.title)
                            .typography(.body3_m_12)
                            .foregroundColor(selectedTab == tab ? .gray1000 : .gray500)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 24.5)
        .padding(.top, 10)
        .frame(height: 54)
        
    }
}

//
//  SplashView.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/13/26.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image("logo")
                
                Spacer()
            }
            .padding(.leading, 24)
            .padding(.top, 157)
            
            HStack(spacing: 0) {
                TypographyText("디데이를 기준으로,\n다운타임 회복을 관리하는 뷰티 캘린더", style: .title1_m_18, color: .gray600)
                
                Spacer()
            }
            .padding(.leading, 24)
            .padding(.top, 8)
            
            Spacer()
        }
    }
}

#Preview() {
    SplashView()
}

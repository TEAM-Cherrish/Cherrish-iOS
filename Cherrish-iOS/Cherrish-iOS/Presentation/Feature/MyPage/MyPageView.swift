//
//  MyPageView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/9/26.
//

import SwiftUI

struct MyPageView: View {
    @StateObject var viewModel: MyPageViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                CherrishLoadingView()
            } else {
                VStack {
                    Spacer()
                        .frame(height: 52.adjustedH)
                    headerView
                    grayEmptyBar
                    prepareView
                        .padding(.horizontal, 35)
                    grayEmptyBar
                }
            }
        }
        .task {
            do {
                try await viewModel.fetchUserInfo()
            } catch {
                CherrishLogger.error(error)
            }
        }
    }
}

extension MyPageView {
    private var headerView: some View {
        HStack (spacing: 14.adjustedW) {
            Image(.illustrationProfile)
                .resizable()
                .frame(width: 48.adjustedW, height: 48.adjustedH)
            
            VStack(alignment: .leading, spacing: 0){
                TypographyText("안녕하세요, \(viewModel.name)님", style: .title1_sb_18, color: .gray1000)
                    .frame(height: 27.adjustedH)
                
                TypographyText("관리 시작 D + \(viewModel.day)", style: .body1_m_14, color: .gray800)
                    .frame(height: 20.adjustedH)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 24.adjustedW)
        
    }
    
    private var prepareView: some View {
        VStack(alignment: .center) {
            Spacer()
                .frame(height: 100.adjustedH)
            
            Image(.illustrationMy)
                .resizable()
                .frame(width: 308.adjustedW, height: 250.adjustedH)
            
            TypographyText("앗! 아직 준비 중이에요.", style: .body1_m_14, color: .gray600)
            
            Spacer()
                .frame(height: 110.adjustedH)
        }
    }
    
    private var grayEmptyBar: some View {
        Rectangle()
            .fill(.gray200)
            .frame(height: 10.adjustedH)
    }
}


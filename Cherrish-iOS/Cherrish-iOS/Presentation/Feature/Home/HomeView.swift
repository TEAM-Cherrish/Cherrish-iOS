//
//  HomeView.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/14/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            VStack(spacing: 0) {
                HeaderLogoView()
                ZStack(alignment: .bottomTrailing) {
                    ChallengeCardView(
                        challengeName: viewModel.challengeName,
                        challengeRate: viewModel.challengeRateText,
                        challengeBarImageName: viewModel.challengeBarImageName
                    )
                    
                    Image(viewModel.cherryLevelImageName)
                        .resizable()
                        .frame(width: 122, height: 122)
                        .offset(x: -24, y: -67)
                }
                PlanBoxView(viewModel: viewModel)
                    .padding(.top, 14)
                
                UpcomingBoxView()
                    .padding(.top, 14)
                Spacer()
            }
        }
        .task {
            await viewModel.loadDashboard()
        }
    }
}

private struct BackgroundGradientView: View {
    var body: some View {
        VStack(spacing: 0) {
            LinearGradient(
                colors: [Color("home_gradient1"), Color("home_gradient2")],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 270)
            
            Color("home_gradient2")
        }
        .ignoresSafeArea()
    }
}

private struct HeaderLogoView: View {
    var body: some View {
        HStack(spacing: 0) {
            Image(.cherrishLogo)
            Spacer()
        }
        .padding(.leading, 32)
        .padding(.top, 40)
    }
}

private struct ChallengeCardView: View {
    let challengeName: String
    let challengeRate: String
    let challengeBarImageName: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TypographyText(challengeName, style: .title2_m_16, color: .gray700)
                TypographyText(challengeRate, style: .title2_m_16, color: .gray1000)
                    .padding(.leading, 4)
                TypographyText("달성", style: .title2_m_16, color: .gray700)
                    .padding(.leading, 4)
                
                Spacer()
            }
            .padding(.horizontal, 18)
            
            Image(challengeBarImageName)
                .padding(.top, 18)
        }
        .frame(height: 109)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .gray0()
        )
        .cherrishShadow()
        .padding(.horizontal, 24)
        .padding(.top, 40)
    }
}

private struct PlanBoxView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var isExpanded: Bool = false
    
    private let maxVisibleCount = 3
    
    private var visibleItems: [MonthPlanItem] {
        let items = viewModel.allMonthPlanItems
        if isExpanded {
            return items
        } else {
            return Array(items.prefix(maxVisibleCount))
        }
    }
    
    private var hasMoreItems: Bool {
        viewModel.allMonthPlanItems.count > maxVisibleCount
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TypographyText(viewModel.formattedDate, style: .body1_m_14, color: .gray700)
                
                Spacer()
            }
            .padding(.top, 18)
            .padding(.leading, 15)
            .padding(.bottom, 4)
            
            if viewModel.allMonthPlanItems.isEmpty {
                emptyStateView
            } else {
                ForEach(visibleItems) { item in
                    MonthPlan(
                        interaction: item.name,
                        dDay: item.dayCount,
                        tag: item.tag
                    )
                    .padding(.top, 8)
                    .padding(.horizontal, 15)
                }
                
                if hasMoreItems {
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isExpanded.toggle()
                        }
                    } label: {
                        TypographyText(
                            isExpanded ? "접기" : "더보기",
                            style: .body1_r_14,
                            color: .gray600
                        )
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 4)
                }
            }
        }
        .padding(.bottom, 14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .gray0()
                .cherrishShadow()
        )
        .padding(.horizontal, 24)

    }
    
    private var emptyStateView: some View {
        HStack {
            TypographyText("진행 중인 일정이 없어요", style: .body1_r_14, color: .gray600)
            Spacer()
        }
        .padding(.vertical, 12.adjustedH)
        .padding(.horizontal, 14.adjustedW)
        .background(.gray0)
        .clipShape(RoundedRectangle(cornerRadius: 10.adjustedW))
        .overlay(
            RoundedRectangle(cornerRadius: 10.adjustedW)
                .strokeBorder(.gray400, lineWidth: 1.adjustedW)
        )
        .padding(.top, 8)
        .padding(.horizontal, 15)
    }
}

private struct UpcomingBoxView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TypographyText("다가오는 일정", style: .body1_m_14, color: .gray700)
                    .padding(.leading, 20)
                    .padding(.vertical, 16)
                
                Spacer()
            }
            
            Divider()
                .gray300()
            
            Spacer()
            
        }
        .frame(height: 109)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .gray0()
        )
        .cherrishShadow()
        .padding(.horizontal, 24)

    }
}

struct PinView: View {
    var color: Color = .pink
    var circleSize: CGFloat = 10
    var lineLength: CGFloat = 65
    var lineWidth: CGFloat = 2
    
    var body: some View {
        VStack(spacing: 0) {
            Circle()
                .fill(color)
                .frame(width: circleSize, height: circleSize)
            
            Rectangle()
                .fill(color)
                .frame(width: lineWidth, height: lineLength)
        }
        
    }
}

#Preview {
    HomeView()
}

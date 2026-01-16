//
//  HomeView.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/14/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    HeaderLogoView()
                    ZStack(alignment: .topTrailing) {
                        if viewModel.cherryLevel == 0 {
                            ChallengeCardEmptyView(
                                challengeBarImageName: viewModel.challengeBarImageName
                            )
                        } else {
                            ChallengeCardView(
                                challengeName: viewModel.challengeName,
                                challengeRate: viewModel.challengeRateText,
                                challengeBarImageName: viewModel.challengeBarImageName
                            )
                        }
                        
                        if viewModel.cherryLevel != 0 {
                            Image(viewModel.cherryLevelImageName)
                                .offset(x: -10.adjustedW, y: -67.adjustedH)
                        }
                    }
                    PlanBoxView(viewModel: viewModel)
                        .padding(.top, 14.adjustedH)
                    
                    UpcomingBoxView(viewModel: viewModel)
                        .padding(.top, 14.adjustedH)
                }
                .padding(.bottom, 20.adjustedH)
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
            .frame(height: 270.adjustedH)
            
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
        .padding(.leading, 32.adjustedW)
        .padding(.top, 40.adjustedH)
    }
}

private struct ChallengeCardEmptyView: View {
    let challengeBarImageName: String
    private let buttonState: ButtonState = .active
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TypographyText("챌린지를 시작해봐요!", style: .body1_m_14, color: .gray700)
                    .padding(.top, 18)

                Spacer()
            }
            .padding(.leading, 18)
            
            Image(challengeBarImageName)
                .padding(.top, 10.adjustedH)
            
            CherrishButton(
                title: "챌린지 시작하기",
                type: .next,
                state: .constant(buttonState)
            ) {
               
            }
            .padding(.horizontal, 24)
            .padding(.top, 10)
            .padding(.bottom, 18)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .gray0()
        )
        .cherrishShadow()
        .padding(.horizontal, 24.adjustedW)
        .padding(.top, 14.adjustedH)
    }
}

private struct ChallengeCardView: View {
    let challengeName: String
    let challengeRate: String
    let challengeBarImageName: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TypographyText("진행 중인 챌린지", style: .body1_m_14, color: .gray700)
                
                Spacer()
            }
            .padding(.leading, 18.adjustedW)
            
            HStack(spacing: 0) {
                TypographyText("웰니스 • 마음챙김", style: .title2_m_16, color: .gray900)
                
                TypographyText("80.9%", style: .body3_m_12, color: .red700)
                    .frame(height: 19.adjustedH)
                    .padding(.horizontal, 7.adjustedW)
                    .background(
                        RoundedRectangle(cornerRadius: 30.adjustedW)
                            .strokeBorder(.red600, lineWidth: 1.adjustedW)
                    )
                    .padding(.leading, 6.adjustedW)
                
                Spacer()
            }
            .padding(.top, 4.adjustedH)
            .padding(.leading, 18.adjustedW)
            
            Image(challengeBarImageName)
                .padding(.top, 16.adjustedH)
        }
        .frame(height: 131.adjustedH)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .gray0()
        )
        .cherrishShadow()
        .padding(.horizontal, 24.adjustedW)
        .padding(.top, 14.adjustedH)
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
            .padding(.top, 18.adjustedH)
            .padding(.leading, 15.adjustedW)
            .padding(.bottom, 4.adjustedH)
            
            if viewModel.allMonthPlanItems.isEmpty {
                emptyStateView
            } else {
                ForEach(visibleItems) { item in
                    MonthPlan(
                        interaction: item.name,
                        dDay: item.dayCount,
                        tag: item.tag
                    )
                    .padding(.top, 8.adjustedH)
                    .padding(.horizontal, 15.adjustedW)
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
                        .frame(width: 296.adjustedW, height: 30.adjustedH)
                        .padding(.top, 6.adjustedH)
                    }
                    .contentShape(Rectangle())
                }
            }
        }
        .padding(.bottom, 14.adjustedH)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .gray0()
                .cherrishShadow()
        )
        .padding(.horizontal, 24.adjustedW)

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
                    .padding(.top, 8.adjustedH)
                    .padding(.horizontal, 15.adjustedW)
    }
}

private struct UpcomingBoxView: View {
    @ObservedObject var viewModel: HomeViewModel
    private let buttonState: ButtonState = .active
    
    private func pinStyle(for index: Int, totalCount: Int) -> (circleColor: Color, lineTopColor: Color, lineBottomColor: Color) {
        let red600 = Color("red_600")
        let red500 = Color("red_500")
        let red300 = Color("red_300")
        let gray0 = Color("gray_0")
        
        let result: (circleColor: Color, lineTopColor: Color, lineBottomColor: Color)
        
        switch index {
        case 0:
            let lineBottomColor = totalCount >= 2 ? red500 : gray0
            result = (red600, red600, lineBottomColor)
        case 1:
            let lineBottomColor = totalCount >= 3 ? red300 : gray0
            result = (red500, red500, lineBottomColor)
        default: 
            result = (red300, red300, gray0)
        }
        
        return result
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TypographyText("다가오는 일정", style: .body1_m_14, color: .gray700)
                    .padding(.leading, 20.adjustedW)
                    .padding(.vertical, 16.adjustedH)
                
                Spacer()
            }
            
            Divider()
                .gray300()
                .padding(.bottom, 11.adjustedH)
            
            if viewModel.upcomingItems.isEmpty {
                emptyStateView
            } else {
                contentView
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .gray0()
        )
        .cherrishShadow()
        .padding(.horizontal, 24.adjustedW)

    }

    private var contentView: some View {
        VStack(spacing: 0) {
            ForEach(Array(viewModel.upcomingItems.enumerated()), id: \.element.id) { index, item in
                let style = pinStyle(for: index, totalCount: viewModel.upcomingItems.count)
                
                HStack(alignment: .top, spacing: 24.adjustedW) {
                    PinView(
                        circleColor: style.circleColor,
                        lineTopColor: style.lineTopColor,
                        lineBottomColor: style.lineBottomColor
                    )
                    .padding(.leading, 26.adjustedW)
                    .offset(y: -12.adjustedH)
                    
                    OnComingCard(
                        date: item.date,
                        name: item.name,
                        count: item.count,
                        dDay: item.dDay
                    )
                }
            }
        }
        .padding(.top, 11.adjustedH)
        .padding(.bottom, 12.adjustedH)
    }

    private var emptyStateView: some View {
        VStack(spacing: 0) {
            Image("illustration_noschedule")
                .padding(.top, 24.adjustedH)
            TypographyText("아직 진행 중인 관리가 없어요.", style: .body1_r_14, color: .gray600)
                .padding(.top, 8.adjustedH)
            
            CherrishButton(
                title: "관리 일정을 추가하기",
                type: .next,
                state: .constant(buttonState)
            ) {
               
            }
            .padding(.horizontal, 24.adjustedW)
            .padding(.top, 32.adjustedH)
            .padding(.bottom, 24.adjustedH)
        }
        .frame(maxWidth: .infinity)
    }
}

struct PinView: View {
    var circleColor: Color
    var lineTopColor: Color
    var lineBottomColor: Color
    var circleSize: CGFloat = 10.adjustedW
    var lineLength: CGFloat = 65.adjustedH
    var lineWidth: CGFloat = 2.adjustedW
    
    var body: some View {
        VStack(spacing: 0) {
            Circle()
                .fill(circleColor)
                .frame(width: circleSize, height: circleSize)
            
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [lineTopColor, lineBottomColor],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: lineWidth, height: lineLength)
        }
    }
}

#Preview {
    HomeView(viewModel: DIContainer.shared.resolve(type: HomeViewModel.self)!)
}

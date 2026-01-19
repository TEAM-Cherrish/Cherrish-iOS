//
//  CalendarView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/9/26.
//

import SwiftUI

enum CalendarMode {
    case none
    case selectedProcedure
    
    mutating func toggle() {
        switch self {
        case .none:
            self = .selectedProcedure
        case .selectedProcedure:
            self = .none
        }
    }
}

struct CalendarView: View {
    @EnvironmentObject private var calendarCoordinator: CalendarCoordinator
    @ObservedObject var viewModel: CalendarViewModel
    @State private var topGlobalY: CGFloat = .zero
    @State private var initialTopGlobalY: CGFloat? = nil
    @State private var bottomOffsetY: CGFloat = .zero
    @State private var calendarMode: CalendarMode = .none
    @State private var selectedProcedureID: Int? = nil
    @State private var buttonState: ButtonState = .active
    
    private let scrollAreaHeight: CGFloat = 184.adjustedH
    
    let weekdays: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    let columns = Array(repeating: GridItem(.fixed(40), spacing: 8), count: 7)
    
    var body: some View {
        VStack {
            calendarHeader
            dateGridsView
            if viewModel.isEmptyProcedureList() {
                emptyScheduleView
            } else {
                scheduleListContainerView
            }
            
        }
        .task {
            do {
                try await viewModel.fetchProcedureCountsOfMonth()
                try await viewModel.fetchTodayProcedureList()
            } catch {
                CherrishLogger.error(error)
            }
        }
        .background(.gray0)
    }
}

extension CalendarView {
    private var calendarHeader: some View {
        VStack {
            HStack {
                Image(.chevronLeft)
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .onTapGesture {
                        viewModel.currentMonth -= 1
                        viewModel.selectedDate = viewModel.firstDateOfCurrentMonth()
                    }
                
                Spacer()
                
                TypographyText("\(viewModel.getYearAndMonthString())", style: .title2_m_16, color: .gray1000)
                
                Spacer()
                
                Image(.chevronRight)
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .onTapGesture {
                        viewModel.currentMonth += 1
                        viewModel.selectedDate = viewModel.firstDateOfCurrentMonth()
                    }
            }
            .padding(.horizontal, 11)
            .padding(.top, 38)
            
            
            HStack(spacing: 8) {
                ForEach(weekdays, id: \.self) { weekday in
                    TypographyText(weekday, style: .body1_r_14, color: .gray800)
                        .frame(width: 40, height: 40)
                }
            }
            .padding(.horizontal, 23)
        }
    }
    
    private var dateGridsView: some View {
        LazyVGrid(columns: columns) {
            ForEach(viewModel.getDatesArray()) { value in
                if value.day != -1 {
                    CalendarCellView(
                        value: value,
                        procedureCount: viewModel.getProcedureCount(for: value),
                        isSelected: viewModel.isSelected(value),
                        downtimeState: viewModel.getDowntimeState(for: value.date),
                        calendarMode: $calendarMode
                    )
                    .onTapGesture {
                        viewModel.select(date: value.date)
                        calendarMode = .none
                        selectedProcedureID = nil
                        
                        Task {
                            do {
                                try await viewModel.fetchTodayProcedureList()
                            } catch {
                                CherrishLogger.error(error)
                            }
                        }
                    }
                } else {
                    Text("").hidden()
                }
            }
        }
        .padding(.horizontal, 23)
    }
    
    private var scheduleListContainerView: some View {
        let procedureCount = viewModel.procedureList.count
        return VStack(spacing: 0) {
            HStack {
                TypographyText("일정 ・ \(procedureCount)개", style: .body1_r_14, color: .gray1000)
                
                Spacer()
                
                switch calendarMode {
                case .none:
                    Image(.plus)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.gray600)
                        .frame(width: 24.adjustedW, height: 24.adjustedH)
                        .onTapGesture {
                            calendarCoordinator.push(.selectTreatment)
                        }
                case .selectedProcedure:
                    downTimeRangeIcons
                }
            }
            .frame(height: 40.adjustedH)
            .padding(.horizontal, 20)
            .padding(.top, 8)
            
            ZStack {
                ScrollView(showsIndicators: false) {
                    scrollViewTopMarkerView
                        .opacity(calendarMode == .none ? 1 : 0)
                        .allowsHitTesting(false)
                    
                    ForEach(viewModel.procedureList, id: \.self) { procedure in
                        ProcedureView(
                            treatmentTitle: procedure.name,
                            treatmentDate: viewModel.selectedDate.toDateString(),
                            downTimeDays: procedure.downtimeDays,
                            calendarMode: $calendarMode,
                            isSelected: selectedProcedureID == procedure.procedureId
                        )
                        .onTapGesture {
                            calendarMode.toggle()
                            selectedProcedureID = procedure.procedureId
                            viewModel.fetchDowntimeByDay(procedureId: procedure.procedureId)
                        }
                    }
                    
                    scrollViewBottomMarkerView
                        .opacity(calendarMode == .none ? 1 : 0)
                        .allowsHitTesting(false)
                }
                .coordinateSpace(name: "ProcedureScroll")
                .onPreferenceChange(ScrollTopPreferenceKey.self) { v in
                    topGlobalY = (calendarMode == .none) ? v : 0
                }
                .onPreferenceChange(ScrollBottomPreferenceKey.self) { v in
                    bottomOffsetY = (calendarMode == .none) ? v : scrollAreaHeight.adjustedH
                }
                
                GradientBox(isTop: true)
                    .frame(height: 56)
                    .allowsHitTesting(false)
                    .opacity(shouldShowGradientTop ? 1 : 0)
                    .frame(maxHeight: .infinity, alignment: .top)
                
                GradientBox(isTop: false)
                    .frame(height: 92)
                    .allowsHitTesting(false)
                    .opacity(shouldShowGradientBottom ? 1 : 0)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            
            .frame(height: scrollAreaHeight.adjustedH)
            .padding(.top, 6)
            .padding(.horizontal, 19)
            .padding(.bottom, 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray0)
                .cherrishShadow()
        )
        .padding(.top, 20)
        .padding(.horizontal, 25)
        .padding(.bottom, 18)
    }
    
    private var emptyScheduleView: some View {
        VStack(alignment: .center) {
            VStack(spacing: 8){
                Image(.illustrationNoschedule)
                    .resizable()
                    .frame(width: 148.adjustedW, height: 108.adjustedH)
                
                TypographyText("오늘 예정된 일정이 없어요.", style: .body1_r_14, color: .gray600)
            }
            .padding(.top, 50)
            .padding(.horizontal, 65)
            
            Spacer()
                .frame(height: 38.adjustedH)
            
            CherrishButton(
                title: "시술 일정 추가하기",
                type: .medium,
                state: $buttonState,
                leadingIcon: Image(.plus),
                trailingIcon: nil,
                action: { calendarCoordinator.push(.selectTreatment) }
            )
            .padding(.horizontal, 24)
            
            Spacer()
                .frame(height: 24.adjustedH)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray0)
                .cherrishShadow()
        )
        .frame(width: 326.adjustedW, height: 264.adjustedH)
        .padding(.top, 20)
        .padding(.horizontal, 25)
        .padding(.bottom, 30)
    }
    
    private var downTimeRangeIcons: some View {
        HStack(spacing: 2.adjustedW) {
            ForEach(DowntimeDayState.displayCases, id: \.self) { state in
                HStack(spacing: 3.adjustedW) {
                    Circle()
                        .fill(state.backgroundColor)
                        .overlay(
                            Circle()
                                .stroke(state.strokeColor, lineWidth: 1)
                        )
                        .frame(width: 12.adjustedW, height: 12.adjustedH)
                    
                    TypographyText("\(state.title)", style: .body3_r_12, color: .gray800)
                }
                .frame(width: 44.adjustedW, height: 20.adjustedH)
            }
        }
    }
    
}

extension CalendarView {
    private var scrollViewTopMarkerView: some View {
        GeometryReader { proxy in
            Color.clear
                .onAppear {
                    let v = proxy.frame(in: .global).minY
                    topGlobalY = v
                    if initialTopGlobalY == nil { initialTopGlobalY = v }
                }
                .onChange(of: proxy.frame(in: .global).minY) { v in
                    topGlobalY = v
                }
        }
        .frame(height: 0)
    }
    
    private var scrollViewBottomMarkerView: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: ScrollBottomPreferenceKey.self,
                    value: proxy.frame(in: .named("ProcedureScroll")).maxY
                )
        }
        .frame(height: 0)
    }
    
    private var shouldShowGradientBottom: Bool {
        guard calendarMode == .none else { return false }
        let remaining = bottomOffsetY - scrollAreaHeight.adjustedH
        return remaining > 1
    }
    
    private var shouldShowGradientTop: Bool {
        guard calendarMode == .none, let initial = initialTopGlobalY else { return false }
        return topGlobalY < initial - 0.1
    }
}

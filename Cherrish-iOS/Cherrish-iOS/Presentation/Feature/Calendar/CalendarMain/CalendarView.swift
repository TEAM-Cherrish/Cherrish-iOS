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
    @StateObject var viewModel: CalendarViewModel
    @StateObject var homeCalendarFlowState: HomeCalendarFlowState
    @State private var topGlobalY: CGFloat = .zero
    @State private var initialTopGlobalY: CGFloat? = nil
    @State private var bottomOffsetY: CGFloat = .zero
    @State private var calendarMode: CalendarMode = .none
    @State private var selectedProcedureID: Int? = nil
    @State private var buttonState: ButtonState = .active
    
    private let scrollAreaHeight: CGFloat = 184.adjustedH
    private let calendarCellWidth: CGFloat = 40.adjustedW
    private let calendarCellHeight: CGFloat = 40.adjustedH
    private let calendarRowSpacing: CGFloat = 8.adjustedH
    
    let weekdays: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    let columns = Array(repeating: GridItem(.fixed(40.adjustedW), spacing: 8), count: 7)
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 38.adjustedH)
            
            calendarHeader
            dateGridsView
            Spacer()
            
            if viewModel.isEmptyProcedureList() {
                emptyScheduleView
            } else {
                scheduleListContainerView
            }
            Spacer()
        }
        .task (id: viewModel.currentMonth){
            if calendarMode == .none {
                do {
                    try await viewModel.fetchProcedureCountsOfMonth()
                    try await viewModel.fetchTodayProcedureList()
                } catch {
                    CherrishLogger.error(error)
                }
            }
        }
        .onChange(of: homeCalendarFlowState.treatmentDate) { _, date in
            if let date = date {
                viewModel.updateDate(date: date)
                homeCalendarFlowState.treatmentDate = nil
            }
        }
        .onAppear {
            if let date = homeCalendarFlowState.treatmentDate {
                viewModel.updateDate(date: date)
                homeCalendarFlowState.treatmentDate = nil
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
                    .frame(width: 40.adjustedW, height: 40.adjustedH)
                    .scaledToFit()
                    .onTapGesture {
                        viewModel.currentMonth -= 1
                        viewModel.selectedDate = viewModel.firstDateOfCurrentMonth()
                    }
                
                Spacer()
                
                TypographyText("\(viewModel.getYearAndMonthString())", style: .title2_m_16, color: .gray1000)
                
                Spacer()
                
                Image(.chevronRight)
                    .frame(width: 40.adjustedW, height: 40.adjustedH)
                    .scaledToFit()
                    .onTapGesture {
                        viewModel.currentMonth += 1
                        viewModel.selectedDate = viewModel.firstDateOfCurrentMonth()
                    }
            }
            .padding(.horizontal, 11.adjustedW)
            
            HStack(spacing: 8) {
                ForEach(weekdays, id: \.self) { weekday in
                    TypographyText(weekday, style: .body1_r_14, color: .gray800)
                        .frame(width: 40.adjustedW, height: 40.adjustedH)
                }
            }
            .padding(.horizontal, 23.adjustedH)
        }
    }
    
    private var dateGridsView: some View {
        let dates = viewModel.getDatesArray()
        let rowCount = dates.count / 7
        
        return VStack(spacing: 0) {
            LazyVGrid(columns: columns, spacing: calendarRowSpacing) {
                ForEach(dates) { value in
                if value.day != -1 {
                    CalendarCellView(
                        value: value,
                        procedureCount: viewModel.getProcedureCount(for: value),
                        isSelected: viewModel.isSelected(value),
                        downtimeState: viewModel.getDowntimeState(for: value.date),
                        isDDay: viewModel.isDDay(for: value.date, selectedProcedureID: selectedProcedureID ?? 0),
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
                    Color.clear
                        .frame(width: calendarCellWidth, height: calendarCellHeight)
                }
            }
            }
            
            if rowCount == 4 {
                Spacer()
                    .frame(height: calendarCellHeight + calendarRowSpacing)
            }
        }
        .padding(.horizontal, 23.adjustedW)
    }
    
    private var scheduleListContainerView: some View {
        let procedureCount = viewModel.procedureList.count
        return VStack(spacing: 0) {
            HStack {
                TypographyText("일정 ・ \(procedureCount)개", style: .body1_m_14, color: .gray1000)
                
                Spacer()
                
                switch calendarMode {
                case .none:
                    Image(.plus)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.gray600)
                        .frame(width: 24.adjustedW, height: 24.adjustedH)
                        .onTapGesture {
                            viewModel.sendDateToTreatmentView()
                            calendarCoordinator.push(.selectTreatment)
                        }
                case .selectedProcedure:
                    downTimeRangeIcons
                }
            }
            .frame(height: 40.adjustedH)
            .padding(.horizontal, 20.adjustedW)
            .padding(.top, 8)
            
            ZStack {
                ScrollView(showsIndicators: false) {
                    scrollViewTopMarkerView
                        .opacity(calendarMode == .none ? 1 : 0)
                        .allowsHitTesting(false)
                    
                    ForEach(viewModel.procedureList, id: \.self) { procedure in
                        ProcedureView(
                            treatmentTitle: procedure.name,
                            treatmentDate: viewModel.treatmentDate,
                            downTimeDays: procedure.downtimeDays,
                            calendarMode: $calendarMode,
                            isSelected: selectedProcedureID == procedure.procedureId
                        )
                        .onTapGesture {
                            calendarMode.toggle()
                            selectedProcedureID = procedure.procedureId
                            
                            Task {
                                do {
                                    try await viewModel.fetchDowntimeByDay(procedureId: procedure.procedureId)
                                }
                                catch {
                                    CherrishLogger.error(error)
                                }
                            }
                        }
                    }
                    
                    scrollViewBottomMarkerView
                        .opacity(calendarMode == .none ? 1 : 0)
                        .allowsHitTesting(false)
                }
                .coordinateSpace(name: "ProcedureScroll")
                .onPreferenceChange(ScrollTopPreferenceKey.self) { v in
                    if initialTopGlobalY == nil { initialTopGlobalY = v }
                    topGlobalY = (calendarMode == .none) ? v : 0
                }
                .onPreferenceChange(ScrollBottomPreferenceKey.self) { v in
                    bottomOffsetY = (calendarMode == .none) ? v : scrollAreaHeight.adjustedH
                }
                
                GradientBox(isTop: true)
                    .frame(height: 56.adjustedH)
                    .allowsHitTesting(false)
                    .opacity(shouldShowGradientTop ? 1 : 0)
                    .frame(maxHeight: .infinity, alignment: .top)
                
                GradientBox(isTop: false)
                    .frame(height: 92.adjustedH)
                    .allowsHitTesting(false)
                    .opacity(shouldShowGradientBottom ? 1 : 0)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            
            .frame(height: scrollAreaHeight.adjustedH)
            .padding(.top, 6.adjustedW)
            .padding(.horizontal, 19.adjustedW)
            .padding(.bottom, 12.adjustedH)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray0)
                .cherrishShadow()
        )
        .padding(.top, 20.adjustedH)
        .padding(.horizontal, 25.adjustedW)
        .padding(.bottom, 18.adjustedH)
    }
    
    private var emptyScheduleView: some View {
        VStack(alignment: .center) {
            Spacer()
                .frame(height: 50.adjustedH)
            
            VStack(alignment: .center, spacing: 8){
                Image(.illustrationNoschedule)
                    .resizable()
                    .frame(width: 98.adjustedW, height: 80.adjustedH)
                
                TypographyText("오늘 예정된 일정이 없어요.", style: .body1_r_14, color: .gray600)
            }
            .frame(width: 148.adjustedW, height: 108.adjustedH)
            .padding(.horizontal, 65.adjustedW)
            
            Spacer()
                .frame(height: 38.adjustedH)
            
            CherrishButton(
                title: "시술 일정 추가하기",
                type: .medium,
                state: $buttonState,
                leadingIcon: Image(.plus),
                trailingIcon: nil,
                action: {
                    viewModel.sendDateToTreatmentView()
                    calendarCoordinator.push(
                        .selectTreatment
                    )
                   
                }
            )
            .padding(.horizontal, 24.adjustedW)
            
            Spacer()
                .frame(height: 24.adjustedH)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray0)
                .cherrishShadow()
        )
        .frame(width: 326.adjustedW, height: 264.adjustedH)
        .padding(.top, 20.adjustedH)
        .padding(.horizontal, 25.adjustedW)
        .padding(.bottom, 30.adjustedH)
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
                    
                    TypographyText("\(state.title)", style: .body3_m_12, color: .gray800)
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
                .preference(
                    key: ScrollTopPreferenceKey.self,
                    value: proxy.frame(in: .named("ProcedureScroll")).minY
                )
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

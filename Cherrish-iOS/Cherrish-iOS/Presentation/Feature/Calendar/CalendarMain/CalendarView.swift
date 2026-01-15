
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
    @ObservedObject var viewModel: CalendarViewModel
    @State private var offsetY: CGFloat = .zero
    @State private var calendarMode: CalendarMode = .none
    @State private var selectedProcedureID: Int? = nil
    
    private let scrollAreaHeight: CGFloat = 184.adjustedH
    
    let weekdays: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    let columns = Array(repeating: GridItem(.fixed(40), spacing: 8), count: 7)
    
    var body: some View {
        VStack {
            calendarHeader
            dateGridsView
            scheduleListConatinerView
        }
        .task {
            do {
                try await viewModel.fetchProcedureCountsOfMonth()
                try await viewModel.fetchTodayProcedureList()
            } catch {
                CherrishLogger.error(error)
            }
        }
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
    
    private var scheduleListConatinerView: some View {
        let procedureCount = viewModel.procedureList.count
        return VStack {
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
                case .selectedProcedure:
                    downTimeRangeIcons
                }
            }
            .frame(height: 40.adjustedH)
            .padding(.horizontal, 20)
            .padding(.top, 8)
            
            ZStack (alignment: .bottom) {
                let isDimMode = (selectedProcedureID != nil)
                ScrollView(showsIndicators: false) {
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
                            viewModel.fetchDowntimeByDay(procedureId: selectedProcedureID ?? 0)
                        }
                    }
                    if calendarMode == .none { scrollViewBottomMarkerView }
                }
                .coordinateSpace(name: "ProcedureScroll")
                .onPreferenceChange(ScrollPreferenceKey.self) { offsetY = $0 }
                
                GradientBox()
                    .frame(height: 92)
                    .allowsHitTesting(false)
                    .opacity(shouldShowGradient ? 1 : 0)
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
    
    private var downTimeRangeIcons: some View {
        HStack(spacing: 2.adjustedW) {
            ForEach(DowntimeDayState.allCases, id: \.self) { state in
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
    private var scrollViewBottomMarkerView: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: ScrollPreferenceKey.self,
                    value: proxy.frame(in: .named("ProcedureScroll")).minY
                )
        }
        .frame(height: 1)
    }
    
    private var shouldShowGradient: Bool {
        offsetY > scrollAreaHeight.adjustedH
    }
}

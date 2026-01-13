
//
//  CalendarView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/9/26.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: CalendarViewModel
    let weekdays: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    let columns = Array(repeating: GridItem(.fixed(40), spacing: 8), count: 7)
    
    var body: some View {
        VStack {
            calendarHeader
            dateGridsView
        }
        .onAppear {
            viewModel.fetchProcedureCountsOfMonth()
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
                        isSelected: viewModel.isSelected(value)
                    )
                    .onTapGesture {
                        viewModel.select(date: value.date)
                    }
                } else {
                    Text("").hidden()
                }
            }
        }
        .padding(.horizontal, 23)
        
    }
}

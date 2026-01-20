//
//  CalendarInterface.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/13/26.
//

import Foundation

protocol CalendarInterface {
    func fetchProcedureCountOfMonth(year: Int, month: Int) async throws -> MonthlyEntity
    func fetchTodayProcedureList(date: String) async throws -> [DailyProcedureEntity]
    func fetchProcedureDowntime(id: Int) async throws -> ProcedureDowntimeEntity
}

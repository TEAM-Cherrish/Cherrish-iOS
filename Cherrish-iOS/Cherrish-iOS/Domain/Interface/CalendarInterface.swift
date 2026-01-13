//
//  CalendarInterface.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/13/26.
//

import Foundation

protocol CalendarInterface {
    func fetchProcedureCountOfMonth(year: Int, month: Int) -> [Int : Int]
    func fetchTodayProcedureList(date: String) -> [ProcedureEntity]
}

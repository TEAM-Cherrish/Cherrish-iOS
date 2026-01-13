//
//  CalendarRepository.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/13/26.
//

import Foundation

struct DefaultCalendarRepository: CalendarInterface {
    func fetchProcedureCountOfMonth(year: Int, month: Int) -> [Int : Int] {
        return [:]
    }
}

struct MockCalendarRepository: CalendarInterface {
    func fetchProcedureCountOfMonth(year: Int, month: Int) -> [Int : Int] {
        return [
            1: 2,
            7: 5,
            15: 1,
            23: 3,
            31: 6
        ]
    }
}

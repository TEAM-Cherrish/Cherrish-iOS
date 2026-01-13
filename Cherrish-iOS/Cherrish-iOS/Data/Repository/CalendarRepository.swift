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
    
    func fetchTodayProcedureList(date: String) -> [ProcedureEntity] {
        return []
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
    
    func fetchTodayProcedureList(date: String) -> [ProcedureEntity] {
        return [
            ProcedureEntity(title: "레이저 토닝", date: "2026-01-13", downtimeDays: 3),
            ProcedureEntity(title: "수분 충전 팩하기", date: "2026-01-13", downtimeDays: 5),
            ProcedureEntity(title: "인모드", date: "2026-01-13", downtimeDays: 6),
            ProcedureEntity(title: "레이저 토닝", date: "2026-01-13", downtimeDays: 3),
            ProcedureEntity(title: "수분 충전 팩하기", date: "2026-01-13", downtimeDays: 5),
            ProcedureEntity(title: "인모드", date: "2026-01-13", downtimeDays: 6)
        ]
    }
}

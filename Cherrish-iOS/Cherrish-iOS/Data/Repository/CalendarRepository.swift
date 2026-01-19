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
            ProcedureEntity(
                procedureId: 1,
                name: "레이저 토닝",
                downtimeDays: 7,
                recoveryTargetDate: "2026-02-07",
                sensitiveDays: [
                    "2026-01-28",
                    "2026-01-29",
                    "2026-01-30"
                ],
                cautionDays: [
                    "2026-01-31",
                    "2026-02-01"
                ],
                recoveryDays: [
                    "2026-02-02",
                    "2026-02-02"
                ]
            ),
            ProcedureEntity(
                procedureId: 2,
                name: "보톡스",
                downtimeDays: 3,
                recoveryTargetDate: "2026-01-17",
                sensitiveDays: [
                    "2026-01-15"
                ],
                cautionDays: [
                    "2026-01-16"
                ],
                recoveryDays: [
                    "2026-01-17"
                ]
            ),
            ProcedureEntity(
                procedureId: 3,
                name: "필러",
                downtimeDays: 5,
                recoveryTargetDate: "2026-01-17",
                sensitiveDays: [
                    "2026-01-15",
                    "2026-01-16"
                ],
                cautionDays: [
                    "2026-01-17",
                    "2026-01-18"
                ],
                recoveryDays: [
                    "2026-01-19"
                ]
            ),
            ProcedureEntity(
                procedureId: 4,
                name: "IPL 레이저",
                downtimeDays: 2,
                recoveryTargetDate: "2026-01-18",
                sensitiveDays: [
                    "2026-01-15"
                ],
                cautionDays: [
                    "2026-01-16"
                ],
                recoveryDays: []
            ),
            ProcedureEntity(
                procedureId: 5,
                name: "윤곽 주사",
                downtimeDays: 4,
                recoveryTargetDate: "2026-01-19",
                sensitiveDays: [
                    "2026-01-15",
                    "2026-01-16"
                ],
                cautionDays: [
                    "2026-01-17"
                ],
                recoveryDays: [
                    "2026-01-18"
                ]
            ),
            ProcedureEntity(
                procedureId: 6,
                name: "피부 스케일링",
                downtimeDays: 0,
                recoveryTargetDate: "2026-01-16",
                sensitiveDays: [
                    "2026-01-15"
                ],
                cautionDays: [],
                recoveryDays: []
            )
        ]
    }
}

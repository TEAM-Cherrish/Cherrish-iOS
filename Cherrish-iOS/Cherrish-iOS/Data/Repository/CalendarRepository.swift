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
                downtimeDays: "7",
                sensitiveDays: [
                    "2026-01-15",
                    "2026-01-16",
                    "2026-01-17"
                ],
                cautionDays: [
                    "2026-01-18",
                    "2026-01-19"
                ],
                recoveryDays: [
                    "2026-01-20",
                    "2026-01-21"
                ]
            ),
            ProcedureEntity(
                procedureId: 2,
                name: "보톡스",
                downtimeDays: "3",
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
                downtimeDays: "5",
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
                downtimeDays: "2",
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
                downtimeDays: "4",
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
                downtimeDays: "1",
                sensitiveDays: [
                    "2026-01-15"
                ],
                cautionDays: [],
                recoveryDays: []
            )
        ]
    }
}

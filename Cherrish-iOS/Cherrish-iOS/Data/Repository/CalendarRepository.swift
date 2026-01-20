//
//  CalendarRepository.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/13/26.
//

import Foundation

struct DefaultCalendarRepository: CalendarInterface {
    private let networkService: NetworkService
    private let userDefaultService: UserDefaultService
    
    init(
        networkService: NetworkService,
        userDefaultService: UserDefaultService
    ) {
        self.networkService = DefaultNetworkService()
        self.userDefaultService = DefaultUserDefaultService()
    }
    
    func fetchProcedureCountOfMonth(year: Int, month: Int) async throws -> MonthlyEntity {
        let userID: Int = userDefaultService.load(key: .userID) ?? 1
        let response = try await networkService.request(
            CalendarAPI.monthly(
                userID: userID,
                year: year,
                month: month
            ),
            decodingType: CalendarMonthlyResponseDTO.self
        )
        
        return response.toEntity()
    }
    
    func fetchTodayProcedureList(date: String) async throws -> [DailyProcedureEntity] {
        let userID: Int = userDefaultService.load(key: .userID) ?? 1
        let response = try await networkService.request(
            CalendarAPI.daily(
                userID: userID,
                date: date
            )
            , decodingType: CalendarDailyResponseDTO.self
        )
        
        return response.toEntity()
    }
    
    func fetchProcedureDowntime(id: Int) async throws -> ProcedureDowntimeEntity {
        let userID: Int = userDefaultService.load(key: .userID) ?? 1
        let response = try await networkService.request(
            CalendarAPI.downtime(
                userID: userID,
                id: id
            )
            , decodingType: CalendarDowntimeResponseDTO.self
        )
        
        return response.toEntity()
    }
}

struct MockCalendarRepository: CalendarInterface {
    func fetchProcedureCountOfMonth(year: Int, month: Int) -> MonthlyEntity {
        return MonthlyEntity.init(
            dailyProcedureCounts: [
                1: 2,
                7: 5,
                15: 1,
                23: 3,
                31: 6]
        )
    }
    
    func fetchTodayProcedureList(date: String) -> [DailyProcedureEntity] {
        return [
            
           ]
    }
    
    func fetchProcedureDowntime(id: Int) async throws -> ProcedureDowntimeEntity {
        return ProcedureDowntimeEntity(
            procedureId: 123,
            downtimeDays: 7,
            recoveryTargetDate: "2026-02-02",
            sensitiveDays: [
                "2026-01-29",
                "2026-01-30"
            ],
            cautionDays: [
                "2026-01-31",
                "2026-02-01"
            ],
            recoveryDays: [
                "2026-02-02"
            ])
    }
}

//
//  FetchTodayProcedureList.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/14/26.
//

import Foundation

protocol FetchTodayProcedureListUseCase {
    func execute(date: String) async throws -> [DailyProcedureEntity]
}

struct DefaultFetchTodayProcedureUseCase: FetchTodayProcedureListUseCase {
    private let repository: CalendarInterface
    
    init(repository: CalendarInterface) {
        self.repository = repository
    }
    
    func execute(date: String) async throws -> [DailyProcedureEntity] {
        try await repository.fetchTodayProcedureList(date: date)
    }
}


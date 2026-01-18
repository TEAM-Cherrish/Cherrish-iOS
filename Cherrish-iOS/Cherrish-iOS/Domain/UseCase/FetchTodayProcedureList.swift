//
//  FetchTodayProcedureList.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/14/26.
//

import Foundation

protocol FetchTodayProcedureList {
    func execute(date: String) async throws -> [ProcedureEntity]
}

struct DefaultFetchTodayProcedure: FetchTodayProcedureList {
    private let repository: CalendarInterface
    
    init(repository: CalendarInterface) {
        self.repository = repository
    }
    
    func execute(date: String) async throws -> [ProcedureEntity] {
        repository.fetchTodayProcedureList(date: date)
    }
}


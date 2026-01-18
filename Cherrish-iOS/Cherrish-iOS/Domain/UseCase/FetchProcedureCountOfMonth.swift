//
//  FetchProcedureCountOfMonth.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/13/26.
//

import Foundation

protocol FetchProcedureCountOfMonth {
    func execute(year: Int, month: Int) async throws -> [Int: Int]
}

struct DefaultFetchProcedureCountOfMonth: FetchProcedureCountOfMonth {
    private let repository: CalendarInterface
    
    init(repository: CalendarInterface) {
        self.repository = repository
    }
    
    func execute(year: Int, month: Int) async throws -> [Int : Int] {
        return repository.fetchProcedureCountOfMonth(year: year, month: month)
    }
}

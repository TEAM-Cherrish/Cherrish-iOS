//
//  FetchProcedureCountOfMonth.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/13/26.
//

import Foundation

protocol FetchProcedureCountOfMonth {
    func execute(year: Int, month: Int) -> [Int: Int]
}

struct DefaultFetchProcedureCountOfMonth: FetchProcedureCountOfMonth {
    private let repopsitory: CalendarInterface
    
    init(repository: CalendarInterface) {
        self.repopsitory = repository
    }
    
    func execute(year: Int, month: Int) -> [Int : Int] {
        return repopsitory.fetchProcedureCountOfMonth(year: year, month: month)
    }
}

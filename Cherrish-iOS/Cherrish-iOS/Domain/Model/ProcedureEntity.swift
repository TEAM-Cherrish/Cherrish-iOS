//
//  ProcedureEntity.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/14/26.
//

import Foundation

struct ProcedureEntity: Identifiable, Hashable {
    var id: UUID
    let title: String
    let date: String
    let downtimeDays: Int
    
    init(
        
        id: UUID = UUID(),
        title: String,
        date: String,
        downtimeDays: Int
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.downtimeDays = downtimeDays
    }
}

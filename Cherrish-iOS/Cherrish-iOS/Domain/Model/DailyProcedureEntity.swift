//
//  DailyProcedureEntity.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/20/26.
//

import Foundation

struct DailyProcedureEntity: Hashable {
    let type: String
    let procedureId: Int
    let name: String
    let downtimeDays: Int
}

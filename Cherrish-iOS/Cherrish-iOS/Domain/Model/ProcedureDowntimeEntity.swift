//
//  ProcedureDowntimeEntity.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/14/26.
//

import Foundation

struct ProcedureDowntimeEntity: Hashable {
    let procedureId: Int
    let downtimeDays: Int
    let recoveryTargetDate: String
    let sensitiveDays: [String]
    let cautionDays: [String]
    let recoveryDays: [String]
}

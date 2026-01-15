//
//  ProcedureEntity.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/14/26.
//

import Foundation

struct ProcedureEntity: Hashable {
    let procedureId: Int
    let name: String
    let downtimeDays: String
    let sensitiveDays: [String]
    let cautionDays: [String]
    let recoveryDays: [String]
}

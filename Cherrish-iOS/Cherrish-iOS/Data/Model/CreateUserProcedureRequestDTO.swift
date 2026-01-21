//
//  UserProcedureItemRequestDTO.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/21/26.
//

import Foundation

struct UserProcedureItemRequestDTO: Encodable {
    let procedureId: Int
    let downtimeDays: Int
}

struct CreateUserProcedureRequestDTO: Encodable {
    let scheduledAt: String
    let recoveryTargetDate: String
    let procedures: [UserProcedureItemRequestDTO]
}

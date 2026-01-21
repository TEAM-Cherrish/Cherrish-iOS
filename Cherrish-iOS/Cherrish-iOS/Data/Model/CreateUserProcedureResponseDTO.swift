//
//  CreateUserProcedureResponseDTO.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/21/26.
//

import Foundation


struct CreateUserProcedureResponseDTO: Decodable {
    let userProcedureId: Int
    let procedureId: Int
    let procedureName: String
    let scheduledAt: String
    let downtimeDays: Int
    let recoveryTargetDate: String
}

struct CreateUserProceduresResponseDTO: Decodable {
    let procedures: [CreateUserProcedureResponseDTO]
}

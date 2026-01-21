//
//  CalendarDowntimeResponseDTO.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/20/26.
//

import Foundation

struct CalendarDowntimeResponseDTO: Decodable {
    let userProcedureId: Int
    let scheduledAt: String
    let downtimeDays: Int
    let recoveryTargetDate: String
    let sensitiveDays: [String]
    let cautionDays: [String]
    let recoveryDays: [String]
}

extension CalendarDowntimeResponseDTO {
    func toEntity() -> ProcedureDowntimeEntity {
        .init(
            procedureId: self.userProcedureId,
            downtimeDays: self.downtimeDays,
            recoveryTargetDate: self.recoveryTargetDate,
            sensitiveDays: self.sensitiveDays,
            cautionDays: self.cautionDays,
            recoveryDays: self.recoveryDays
        )
    }
}

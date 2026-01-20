//
//  CalendarMonthlyResponseDTO.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/20/26.
//

import Foundation

struct CalendarMonthlyResponseDTO: Decodable {
    let dailyProcedureCounts: [String: Int]
}

extension CalendarMonthlyResponseDTO {
    func toEntity() -> MonthlyEntity {
        let mapped = dailyProcedureCounts.reduce(into: [Int: Int]()) { result, entry in
            guard let key = Int(entry.key) else { return }
            result[key] = entry.value
        }
        return .init(dailyProcedureCounts: mapped)
    }
}

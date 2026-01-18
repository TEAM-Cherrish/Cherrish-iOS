//
//  Int+.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/19/26.
//

import Foundation

extension Int {
    static func daysBetween(
        fromYear: Int, fromMonth: Int, fromDay: Int,
        toYear: Int, toMonth: Int, toDay: Int
    ) -> Int {
        let calendar = Calendar.current
        
        guard let fromDate = calendar.date(from: DateComponents(year: fromYear, month: fromMonth, day: fromDay)),
              let toDate = calendar.date(from: DateComponents(year: toYear, month: toMonth, day: toDay)) else {
            return 0
        }
        
        return abs(calendar.dateComponents([.day], from: fromDate, to: toDate).day ?? 0)
    }
}

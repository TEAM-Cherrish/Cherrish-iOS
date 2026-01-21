//
//  Date+.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/12/26.
//

import Foundation

extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        return range.compactMap { day -> Date in
            calendar.date(byAdding: .day, value: day - 1, to: startDate) ?? Date()
        }
    }
    
    func toDateString() -> String {
        return Date.dateFormatter.string(from: self)
    }
}

extension Date {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter
    }()
    
    static func daysBetween(
        from: (year: Int, month: Int, day: Int),
        to: (year: Int, month: Int, day: Int)
    ) -> Int? {
        let calendar = Calendar.current
        
        guard let fromDate = calendar.date(from: DateComponents(year: from.year, month: from.month, day: from.day)),
              let toDate = calendar.date(from: DateComponents(year: to.year, month: to.month, day: to.day)) else {
            return nil
        }
        
        return abs(calendar.dateComponents([.day], from: fromDate, to: toDate).day ?? 0)
    }
}

extension Date {
    var toScheduledAtFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.string(from: self)
    }
    
    var toRecoveryDateFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    static func from(year: String, month: String, day: String) -> Date? {
        guard let y = Int(year),
              let m = Int(month),
              let d = Int(day) else { return nil }
        
        var components = DateComponents()
        components.year = y
        components.month = m
        components.day = d
        return Calendar.current.date(from: components)
    }
}

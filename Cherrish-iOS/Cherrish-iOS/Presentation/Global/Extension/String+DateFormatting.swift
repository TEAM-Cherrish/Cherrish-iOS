//
//  String+DateFormatting.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/14/26.
//

import Foundation

extension String {
    var toKoreanMonthDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let parsedDate = formatter.date(from: self) else {
            return self
        }
        
        formatter.dateFormat = "M월 d일"
        return formatter.string(from: parsedDate)
    }
}

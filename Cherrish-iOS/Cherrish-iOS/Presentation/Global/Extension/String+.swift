//
//  String+.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/14/26.
//

import Foundation

extension String {
    private static let inputFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
    
    private static let outputFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일 EEEE"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
    
    func dateFormatter() -> String {
        guard let date = String.inputFormatter.date(from: self) else {
            return self
        }

        return String.outputFormatter.string(from: date)
    }
    
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

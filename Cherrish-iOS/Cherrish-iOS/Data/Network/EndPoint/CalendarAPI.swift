//
//  CalendarAPI.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/20/26.
//

import Foundation

import Alamofire

enum CalendarAPI {
    case monthly(userID: Int, year: Int, month: Int)
    case daily(userID: Int)
    case downtime(userID: Int, id: Int)
}

extension CalendarAPI: EndPoint {

    var basePath: String {
        return "/api/calendar"
    }
    
    var path: String {
        switch self {
        case .monthly:
            return "/monthly"
        case .daily:
            return "/daily"
        case .downtime(_, let id):
            return "/events/\(id)/downtime"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .monthly, .daily, .downtime:
            return .get
        }
    }
    
    var headers: HeaderType {
        switch self {
        case .monthly(let userID, _, _),
                .daily(let userID),
                .downtime(let userID, _):
            return .withAuth(userID: userID)
        }
    }
    
    var parameterEncoding: any Alamofire.ParameterEncoding {
        switch self {
        case .monthly, .daily, .downtime:
            return JSONEncoding()
        }
    }
    
    var queryParameters: [String : Any]? {
        switch self {
        case .monthly(_, let year, let month):
            return ["year": year, "month": month]
        case .daily, .downtime:
            return nil
        }
    }
    
    var bodyParameters: Alamofire.Parameters? {
        switch self {
        case .monthly, .daily, .downtime:
            return nil
        }
    }
    
}

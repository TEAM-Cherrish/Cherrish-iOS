//
//  HomeAPI.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/18/26.
//

import Foundation

import Alamofire

enum HomeAPI {
    case fetchDashboard(userID: Int)
}

extension HomeAPI: EndPoint {
    
    var basePath: String {
        "/api"
    }
    
    var path: String {
        switch self {
        case .fetchDashboard:
            return "/main-dashboard"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchDashboard:
            return .get
        }
    }
    
    var headers: HeaderType {
        switch self {
        case .fetchDashboard(let userID):
            return .withAuth(userID: userID)
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .fetchDashboard:
            return URLEncoding.default
        }
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case .fetchDashboard:
            return nil
        }
    }
    
    var bodyParameters: Parameters? {
        switch self {
        case .fetchDashboard:
            return nil
        }
    }
}

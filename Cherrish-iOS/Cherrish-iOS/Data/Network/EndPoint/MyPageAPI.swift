//
//  MyPageAPI.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/20/26.
//

import Foundation

import Alamofire

enum MyPageAPI {
    case users(userID: Int)
}

extension MyPageAPI: EndPoint {
    var basePath: String {
        return "/api"
    }
    
    var path: String {
        switch self {
        case .users:
            return "/users"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .users:
            return .get
        }
    }
    
    var headers: HeaderType {
        switch self {
        case .users(let userID):
            return .withAuth(userID: userID)
        }
    }
    
    var parameterEncoding: any Alamofire.ParameterEncoding {
        switch self {
        case .users:
            return URLEncoding.default
        }
    }
    
    var queryParameters: [String : Any]? {
        return nil
    }
    
    var bodyParameters: Alamofire.Parameters? {
        return nil
    }
    
    
}

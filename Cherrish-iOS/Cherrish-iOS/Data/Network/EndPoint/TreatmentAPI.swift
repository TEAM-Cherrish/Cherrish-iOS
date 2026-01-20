//
//  TreatmentAPI.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/20/26.
//

import Foundation

import Alamofire

enum TreatmentAPI: EndPoint {
    case fetchCategories(userId: Int)
    
    var basePath: String {
        switch self {
        case .fetchCategories:
            return "/api"
        }
    }
    
    var path: String {
        switch self {
        case .fetchCategories:
            return "/worries"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchCategories:
            return .get
        }
    }
    
    var headers: HeaderType {
        switch self {
        case .fetchCategories(let userId):
            return .withAuth(userID: userId)
        }
    }
    
    
    var parameterEncoding: any Alamofire.ParameterEncoding {
        switch self {
        case .fetchCategories:
            return URLEncoding.default
        }
    }
    
    var queryParameters: [String : Any]? {
        switch self {
        case .fetchCategories:
            return nil
        }
    }
    
    var bodyParameters: Alamofire.Parameters? {
        switch self {
        case .fetchCategories:
            return .none
        }
    }
    
    
}


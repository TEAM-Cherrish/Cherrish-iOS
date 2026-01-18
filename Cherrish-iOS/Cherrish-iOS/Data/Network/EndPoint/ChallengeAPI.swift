//
//  ChallengeAPI.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/19/26.
//

import Foundation

import Alamofire

enum ChallengeAPI {
    case homecareRoutines
}
    
extension ChallengeAPI {
    
    var baseURL: String {
        return Environment.baseURL
    }
    
    var path: String {
        switch self {
        case .homecareRoutines:
            return "/api/challenges/homecare-routines"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .homecareRoutines:
            return .get
        }
    }
    var headers: HTTPHeaders? {
        switch self {
        case .homecareRoutines:
            return nil
        }
    }
        
    var parameters: Parameters? {
        switch self {
        case .homecareRoutines:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .homecareRoutines:
            return URLEncoding.default
        }
    }
    
    var url: String {
        return baseURL + path
    }
}

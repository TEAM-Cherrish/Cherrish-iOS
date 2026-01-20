//
//  ChallengeAPI.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/19/26.
//

import Foundation
import Alamofire

enum ChallengeAPI: EndPoint {
    case fetchRoutines
    case aiRecommendations(homecareRoutineId: Int)
    
    var basePath: String {
        return "/api/challenges"
    }
    
    var path: String {
        switch self {
        case .fetchRoutines:
            return "/homecare-routines"
        case .aiRecommendations:
            return "/ai-recommendations"
        }
    }
    
    
    var method: Alamofire.HTTPMethod{
        switch self {
        case .fetchRoutines:
            return .get
        case .aiRecommendations:
            return .post
        }
    }
    
    
    var headers: HeaderType {
        switch self {
        case .fetchRoutines:
            return .basic
        case .aiRecommendations:
            return .basic
        }
    }
    
    var parameterEncoding: any Alamofire.ParameterEncoding {
        switch self {
        case .fetchRoutines:
            return JSONEncoding.default
        case .aiRecommendations:
            return JSONEncoding.default
        }
    }
    
    var queryParameters: [String : String]? {
        switch self {
        case .fetchRoutines:
            return nil
        case .aiRecommendations:
            return nil
        }
    }
    
    var bodyParameters: Alamofire.Parameters? {
        switch self {
        case .fetchRoutines:
            return nil
        case .aiRecommendations(let homecareRoutineId):
            return ["homecareRoutineId" : homecareRoutineId]
        }
    }
    
    
}

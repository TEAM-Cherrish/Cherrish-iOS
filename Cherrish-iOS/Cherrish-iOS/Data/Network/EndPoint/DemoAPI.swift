//
//  DemoAPI.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/21/26.
//

import Foundation

import Alamofire

enum DemoAPI {
    case fetchChallenges(userID: Int)
    case advance(userID: Int)
    case routineToggle(userID: Int, routineID: Int)
    case createChallenge(userID: Int, requestDTO: MakeChallengeRequestDTO)
}

extension DemoAPI: EndPoint {
    var basePath: String {
        "/api/demo/challenges"
    }
    
    var path: String {
        switch self {
        case .fetchChallenges, .createChallenge:
            return ""
        case .advance:
            return "/advance-day"
        case .routineToggle(_, let routineID):
            return "/routines/\(routineID)/toggle"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchChallenges:
            return .get
        case .advance, .createChallenge:
            return .post
        case .routineToggle(_, let routineID):
            return .patch
        }
    }
    
    var headers: HeaderType {
        switch self {
        case .fetchChallenges(let userID),
                .advance(let userID),
                .routineToggle(let userID, _),
                .createChallenge(let userID, _):
            return .withAuth(userID: userID)
        }
    }
    
    var parameterEncoding: any Alamofire.ParameterEncoding {
        switch self {
        case .fetchChallenges:
            return URLEncoding.default
        case .advance, .routineToggle, .createChallenge:
            return JSONEncoding.default
        }
    }
    
    var queryParameters: [String : Any]? {
        return nil
    }
    
    var bodyParameters: Alamofire.Parameters? {
        switch self {
        case .createChallenge(_, let dto):
            return try? dto.toDictionary()
        case .fetchChallenges, .advance, .routineToggle:
            return nil
        }
    }
}

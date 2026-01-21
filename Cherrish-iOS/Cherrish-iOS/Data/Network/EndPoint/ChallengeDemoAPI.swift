//
//  ChallengeDemoAPI.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/21/26.
//

import Foundation
import Alamofire

enum ChallengeDemoAPI: EndPoint {
    case createChallenge(userID: Int, requestDTO: MakeChallengeRequestDTO)

    var basePath: String {
        return "/api/demo"
    }

    var path: String {
        switch self {
        case .createChallenge:
            return "/challenges"
        }
    }

    var method: Alamofire.HTTPMethod{
        switch self {
        case .createChallenge:
            return .post
        }
    }


    var headers: HeaderType {
        switch self {
        case .createChallenge(let userID, _):
            return .withAuth(userID: userID)
        }
    }

    var parameterEncoding: any Alamofire.ParameterEncoding {
        switch self {
        case .createChallenge:
            return JSONEncoding.default
        }
    }

    var queryParameters: [String : Any]? {
        switch self {
        case .createChallenge:
            return nil
        }
    }

    var bodyParameters: Parameters? {
        switch self {
        case .createChallenge(_, let dto):
            return try? dto.toDictionary()
        }
    }
}

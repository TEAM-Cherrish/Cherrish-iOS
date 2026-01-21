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
    case fetchProcedures(userId: Int, id: Int? = nil, text: String? = nil)
    case createUserProcedure(userId: Int, request: CreateUserProcedureRequestDTO)
    
    var basePath: String {
        switch self {
        case .fetchCategories:
            return "/api"
        case .fetchProcedures:
            return "/api"
        case .createUserProcedure:
            return "/api"
        }
    }
    
    var path: String {
        switch self {
        case .fetchCategories:
            return "/worries"
        case .fetchProcedures:
            return "/procedures"
        case .createUserProcedure:
            return "/user-procedures"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchCategories:
            return .get
        case .fetchProcedures:
            return .get
        case .createUserProcedure:
            return .post
        }
    }
    
    var headers: HeaderType {
        switch self {
        case .fetchCategories(let userId):
            return .withAuth(userID: userId)
        case .fetchProcedures(let userId, _,  _):
            return .withAuth(userID: userId)
        case .createUserProcedure(let userId, _):
            return .withAuth(userID: userId)
            
        }
    }
    
    
    var parameterEncoding: any Alamofire.ParameterEncoding {
        switch self {
        case .fetchCategories:
            return URLEncoding.default
        case .fetchProcedures:
            return URLEncoding.default
        case .createUserProcedure:
            return JSONEncoding.default
        }
    }
    
    var queryParameters: [String : Any]? {
        switch self {
        case .fetchCategories:
            return nil
        case .fetchProcedures(_, let id, let text):
            var params: [String: Any] = [:]
            if let id = id {
                params["worryId"] = id
            }
            if let text = text {
                params["keyword"] = "\(text)"
            }
            return params
        case .createUserProcedure:
            return nil
        }
    }
    
    
    var bodyParameters: Alamofire.Parameters? {
        switch self {
        case .fetchCategories:
            return .none
        case .fetchProcedures:
            return .none
        case .createUserProcedure(_, let request):
            return [
                "scheduledAt": request.scheduledAt,
                "recoveryTargetDate": request.recoveryTargetDate,
                "procedures": request.procedures.map {
                    [
                        "procedureId": $0.procedureId,
                        "downtimeDays": $0.downtimeDays
                    ]
                }
            ]
        }
    }
}

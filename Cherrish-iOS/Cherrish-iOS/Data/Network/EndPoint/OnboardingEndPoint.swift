//
//  OnboardingEndPoint.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/18/26.
//

import Foundation

import Alamofire

enum OnboardingEndPoint: EndPoint {
    case createProfile(request: CreateProfileRequestDTO)
    
    var basePath: String {
        return "/api/onboarding"
    }
    
    var path: String {
        switch self {
        case .createProfile:
            return "/profiles"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .createProfile:
            return .post
        }
    }
    
    var headers: HeaderType {
        switch self {
        case .createProfile:
            return .basic
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var queryParameters: [String: String]? {
        return nil
    }
    
    var bodyParameters: Parameters? {
        switch self {
        case .createProfile(let request):
            return [
                "name": request.name,
                "age": request.age
            ]
        }
    }
}

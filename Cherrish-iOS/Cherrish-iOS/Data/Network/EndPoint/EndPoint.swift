//
//  EndPoint.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/10/26.
//

import Foundation

import Alamofire

protocol EndPoint {
    
    /// ex) /api/v1/challenge/start?mission={mission}
    ///
    /// basePath: /api/v1/challenge
    /// path: /start
    /// method: get
    /// headers: withAuth(userID: Int)
    /// parameterEncoding: URLEncoding, JSONEncoding
    /// queryParameters: [mission: mission[
    /// bodyParameteres: nil
    ///

    var basePath: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HeaderType { get }
    var parameterEncoding: ParameterEncoding { get }
    var queryParameters: [String: Any]? { get }
    var bodyParameters: Parameters? { get }
    
    var requestURL: URL { get }
}

extension EndPoint {
    var requestURL: URL {
        let baseURL = Environment.baseURL 
        let urlString = baseURL + basePath + path
        
        guard var urlComponents = URLComponents(string: urlString) else {
            CherrishLogger.error(CherrishError.URLError)
            return URL(string: "")!
        }
        
        if let queryParameters {
            urlComponents.queryItems = queryParameters.map {
                URLQueryItem(
                    name: $0.key,
                    value: String(describing: $0.value)
                )
            }
        }
        
        guard let url = urlComponents.url else {
            CherrishLogger.error(CherrishError.URLError)
            return URL(string: "")!
        }
        
        return url
    }
}

enum HeaderType {
    case basic
    case withAuth(userID: Int)
    
    var value: HTTPHeaders {
        switch self {
        case .basic:
            return ["Content-Type" : "application/json"]
        case .withAuth(let userID):
            return [
                "Content-Type": "application/json",
                "X-User-Id": "\(userID)"
            ]
        }
    }
}

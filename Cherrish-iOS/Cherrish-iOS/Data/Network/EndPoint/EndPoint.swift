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
    var queryParmaters: [String: String]? { get }
    var bodyParameters: Parameters? { get }
    
    var requestURL: URL { get }
}

extension EndPoint {
    var requestURL: URL {
        let baseURL = "" // TODO: 서버 배포 후 수정
        let urlString = baseURL + basePath + path
        
        guard var urlComponents = URLComponents(string: urlString) else {
            CherrishLogger.error(CherrishError.URLError)
            return URL(string: "")!
        }
        
        if let queryParmaters {
            urlComponents.queryItems = queryParmaters.map {
                URLQueryItem(name: $0, value: $1)
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
                "userID": "\(userID)" // TODO: 서버 구조에 맞춰 수정
            ]
        }
    }
}

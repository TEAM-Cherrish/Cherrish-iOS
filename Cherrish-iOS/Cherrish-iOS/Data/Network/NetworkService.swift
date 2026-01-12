//
//  NetworkService.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/10/26.
//

import Foundation

import Alamofire

protocol NetworkService {
    func request<T: Decodable>(
        _ endPoint: EndPoint,
        decodingType: T.Type
    ) async throws -> T
    func request(_ endPoint: EndPoint) async throws
}

final class DefaultNetworkService: NetworkService {
    
    func request<T: Decodable>(
        _ endPoint: EndPoint,
        decodingType: T.Type)
    async throws -> T {
        requestLogger(endPoint)
        
        let response = await AF.request(
            endPoint.requestURL,
            method: endPoint.method,
            parameters: endPoint.bodyParameters,
            encoding: endPoint.parameterEncoding,
            headers: endPoint.headers.value
        )
        .validate()
        .serializingData()
        .response

        responseLogger(response)
        
        if let error = response.error {
           let statusCode = response.response?.statusCode ?? -1
            
           if let data = response.data,
              let errorResponse = try? JSONDecoder().decode(EmptyResponseDTO.self, from: data) {
               let cherrishError = handleError(statusCode, errorResponse.message)
               CherrishLogger.error(cherrishError)
               throw cherrishError
           } else {
               CherrishLogger.error(error)
               throw error
           }
       }

       guard let data = response.data else {
           CherrishLogger.error(CherrishError.noData)
           throw CherrishError.noData
       }

       let decoded = try JSONDecoder().decode(BaseResponseDTO<T>.self, from: data)

       guard let decodedData = decoded.data else {
           CherrishLogger.error(CherrishError.noData)
           throw CherrishError.noData
       }

        return decodedData
    }
    
    func request(_ endPoint: EndPoint) async throws {
        requestLogger(endPoint)
        
        let response = await AF.request(
            endPoint.requestURL,
            method: endPoint.method,
            parameters: endPoint.bodyParameters,
            encoding: endPoint.parameterEncoding,
            headers: endPoint.headers.value
        )
        .validate()
        .serializingData()
        .response
        
        responseLogger(response)
        
        if let error = response.error {
            let statusCode = response.response?.statusCode ?? -1
            
            if let data = response.data,
               let errorResponse = try? JSONDecoder().decode(EmptyResponseDTO.self, from: data) {
                let cherrishError = handleError(statusCode, errorResponse.message)
                CherrishLogger.error(cherrishError)
                throw cherrishError
            } else {
                CherrishLogger.error(error)
                throw error
            }
        }
    }
    
    private func requestLogger(_ endPoint: EndPoint) {
        CherrishLogger.network("[Request Start]")
        CherrishLogger.network("URL: \(endPoint.requestURL)")
        CherrishLogger.network("Method: \(endPoint.method.rawValue)")
        CherrishLogger.network("Headers: \(endPoint.headers.value)")
        CherrishLogger.network("Parameters: \(String(describing: endPoint.bodyParameters))")
    }
    
    private func responseLogger<T>(_ response: DataResponse<T, AFError>) {
        CherrishLogger.network("[Response Start]")
        CherrishLogger.network("StatusCode: \(String(describing: response.response?.statusCode))")
        CherrishLogger.network("Header: \(String(describing: response.response?.headers))")
        CherrishLogger.network("Description: \(String(describing: response.response?.description))")
    }
    
    private func handleError(_ statusCode: Int, _ errorResponse: String) -> CherrishError {
        let error: CherrishError

        switch statusCode {
        case 400:
            error = .badRequest
        case 401:
            error = .unauthorized
        case 403:
            error = .forbidden
        case 404:
            error = .notFound
        case 409:
            error = .conflict
        case 429:
            error = .tooManyRequests
        default:
            error = .networkError(
                code: statusCode,
                message: errorResponse
            )
        }
        
        return error
    }
}

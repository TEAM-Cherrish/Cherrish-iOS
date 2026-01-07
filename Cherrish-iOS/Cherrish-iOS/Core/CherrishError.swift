//
//  CherrishError.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/8/26.
//

import Foundation

enum CherrishError: Error, LocalizedError, Equatable {
    case DIFailedError
    case decodingError
    case URLError
    case networkRequestFailed
    case networkConnect
    case networkError(code: Int, message: String)
    case noData
    case unknownError
    case encodingError

    var errorDescription: String? {
        switch self {
        case .DIFailedError:
            return "의존성 주입 실패"
        case .decodingError:
            return "디코딩 실패"
        case .URLError:
            return "URL 변환 실패"
        case .networkRequestFailed:
            return "네트워크 요청 실패"
        case .networkConnect:
            return "네트워크 연결 에러"
        case .networkError(let code, let message):
            return "\(code): \(message)"
        case .noData:
            return "데이터 없음"
        case .encodingError:
            return "인코딩 실패"
        case .unknownError:
            return "알 수 없는 오류"
        }
    }
}

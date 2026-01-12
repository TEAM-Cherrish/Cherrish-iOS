//
//  BaseResponseDTO.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/10/26.
//

import Foundation

struct BaseResponseDTO<T: Decodable>: Decodable {
    let code: String
    let message: String
    let data: T?
}

struct EmptyResponseDTO: Decodable {
    let code: String
    let message: String
}

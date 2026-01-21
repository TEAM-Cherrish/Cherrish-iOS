//
//  UserInfoResponseDTO.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/20/26.
//

import Foundation

struct UserInfoResponseDTO: Decodable {
    let name: String
    let daysSinceSignup: Int
}

extension UserInfoResponseDTO {
    func toEntity() -> UserInfoEntity {
        .init(name: name, daysSinceSignup: daysSinceSignup)
    }
}

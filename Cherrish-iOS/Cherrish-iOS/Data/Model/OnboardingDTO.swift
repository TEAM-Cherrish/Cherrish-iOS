//
//  OnboardingDTO.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/18/26.
//

import Foundation


struct CreateProfileRequestDTO: Encodable {
    let name: String
    let age: Int
}


struct CreateProfileResponseDTO: Decodable {
    let id: Int
    let name: String
    let date: String
}


extension CreateProfileResponseDTO {
    func toEntity() -> ProfileEntity {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let createdDate = dateFormatter.date(from: date) ?? Date()
        return ProfileEntity(id: id, name: name, createdDate: createdDate)
    }
}

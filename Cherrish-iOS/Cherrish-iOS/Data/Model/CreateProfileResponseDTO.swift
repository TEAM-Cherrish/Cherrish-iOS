//
//  CreateProfileResponseDTO.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/18/26.
//

import Foundation

struct CreateProfileResponseDTO: Decodable {
    let id: Int
    let name: String
    let date: String
}

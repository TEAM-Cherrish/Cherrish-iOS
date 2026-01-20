//
//  TreatmentEntity.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/12/26.
//

import Foundation

struct TreatmentEntity: Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let benefits: [String]
    let downtimeMin: Int
    let downtimeMax: Int
    let setDowntime: Int?
}

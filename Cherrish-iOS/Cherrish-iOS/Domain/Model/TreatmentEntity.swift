//
//  TreatmentEntity.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/12/26.
//

import Foundation

struct TreatmentEntity: Equatable, Hashable {
    var id: Self { self }
    let name: String
    let benefits: [String]
    let downtimeMin: Int
    let downtimeMax: Int
}

extension TreatmentEntity {
    static let mockData: [TreatmentEntity] = [
        // 피부결 · 각질
        TreatmentEntity(
            name: "아쿠아필",
            benefits: ["각질 제거", "모공 청소", "피부결 개선"],
            downtimeMin: 0,
            downtimeMax: 1
        ),
        TreatmentEntity(
            name: "크리스탈 필링",
            benefits: ["각질 제거", "피부 톤 개선", "잔주름 완화"],
            downtimeMin: 1,
            downtimeMax: 3
        ),
        
        // 색소 · 잡티
        TreatmentEntity(
            name: "피코토닝",
            benefits: ["색소 침착 개선", "잡티 제거", "피부 톤 균일화"],
            downtimeMin: 0,
            downtimeMax: 1
        ),
        TreatmentEntity(
            name: "레이저토닝",
            benefits: ["기미 개선", "색소 침착 완화", "피부 톤 업"],
            downtimeMin: 1,
            downtimeMax: 2
        ),
        
        // 홍조
        TreatmentEntity(
            name: "브이빔 레이저",
            benefits: ["홍조 완화", "혈관 축소", "피부 진정"],
            downtimeMin: 1,
            downtimeMax: 3
        ),
        TreatmentEntity(
            name: "엑셀브이",
            benefits: ["홍조 개선", "안면홍조 치료", "혈관 병변 제거"],
            downtimeMin: 2,
            downtimeMax: 5
        ),
        
        // 탄력 · 주름
        TreatmentEntity(
            name: "울쎄라",
            benefits: ["리프팅", "탄력 개선", "주름 완화"],
            downtimeMin: 3,
            downtimeMax: 7
        ),
        TreatmentEntity(
            name: "써마지",
            benefits: ["피부 탄력", "콜라겐 생성", "처진 피부 개선"],
            downtimeMin: 0,
            downtimeMax: 2
        ),
        TreatmentEntity(
            name: "보톡스",
            benefits: ["주름 개선", "이마 주름", "미간 주름"],
            downtimeMin: 0,
            downtimeMax: 1
        ),
        
        // 모공
        TreatmentEntity(
            name: "프락셀",
            benefits: ["모공 축소", "피부 재생", "흉터 개선"],
            downtimeMin: 5,
            downtimeMax: 7
        ),
        TreatmentEntity(
            name: "모공보톡스",
            benefits: ["모공 축소", "피지 조절", "매끈한 피부"],
            downtimeMin: 0,
            downtimeMax: 1
        ),
        
        // 트러블
        TreatmentEntity(
            name: "PDT",
            benefits: ["여드름 치료", "피지 조절", "염증 완화"],
            downtimeMin: 2,
            downtimeMax: 5
        ),
        TreatmentEntity(
            name: "압출 관리",
            benefits: ["여드름 제거", "모공 청소", "피부 진정"],
            downtimeMin: 1,
            downtimeMax: 3
        )
    ]
}

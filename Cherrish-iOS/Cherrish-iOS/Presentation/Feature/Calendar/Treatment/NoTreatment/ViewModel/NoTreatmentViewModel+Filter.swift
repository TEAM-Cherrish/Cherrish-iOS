//
//  NoTreatmentViewModel+Filter.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import Foundation

extension NoTreatmentViewModel {
    
    func addTreatment(_ treatment: TreatmentEntity) {
        guard !isSelected(treatment) else { return }
        selectedTreatments.append(treatment)
    }

    func removeTreatment(_ treatment: TreatmentEntity) {
        selectedTreatments.removeAll { $0.id == treatment.id }
    }
    func isSelected(_ treatment: TreatmentEntity) -> Bool {
        selectedTreatments.contains(where: { $0.id == treatment.id })
    }
}

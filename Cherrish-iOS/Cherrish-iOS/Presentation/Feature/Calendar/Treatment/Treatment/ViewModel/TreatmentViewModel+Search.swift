//
//  TreatmentViewModel+Search.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/17/26.
//

import Combine
import Foundation

extension TreatmentViewModel {
    
    func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterTreatments(by: text)
            }
            .store(in: &cancellables)
    }
    
    func filterTreatments(by text: String) {
        if text.isEmpty {
            filteredTreatments = treatments
        } else {
            filteredTreatments = treatments.filter {
                $0.name.localizedCaseInsensitiveContains(text)
            }
        }
    }
    
    func clearSearch() {
        searchText = ""
    }
}

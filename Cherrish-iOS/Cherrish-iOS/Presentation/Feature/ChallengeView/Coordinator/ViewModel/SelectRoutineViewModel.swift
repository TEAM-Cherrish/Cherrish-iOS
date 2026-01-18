//
//  SelectRoutineViewModel.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/16/26.
//

import SwiftUI

struct Routine: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
    let description: String
}

final class SelectRoutineViewModel: ObservableObject {
    
    @Published var routines: [Routine] = []
    @Published var selectedRoutine: Routine?
    
    private let challengeRepository: ChallengeInterface
    
    init(
        challengeRepository: ChallengeInterface = DIContainer.shared.resolve(type: ChallengeInterface.self)!
    ) {
        self.challengeRepository = challengeRepository
    }
    
    var nextButtonState: ButtonState {
        selectedRoutine == nil ? .normal : .active
    }
    
    func select(_ routine: Routine) {
        selectedRoutine = routine
    }
    
    func fetchRoutines() {
        challengeRepository.fetchHomecareRoutines { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dtos):
                    self?.routines = dtos.map {
                        Routine(
                            id: $0.id,
                            name: $0.name,
                            description: $0.description
                        )
                    }

                case .failure(let error):
                    CherrishLogger.error(error)
                    self?.routines = []
                }
            }
        }
    }

}

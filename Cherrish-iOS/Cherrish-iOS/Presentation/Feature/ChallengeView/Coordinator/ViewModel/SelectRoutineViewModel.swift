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
    
    @Published var routines: [RoutineEntity] = []
    @Published var selectedRoutine: RoutineEntity?
    
    private let challengeRepository: ChallengeInterface
    
    init(
        challengeRepository: ChallengeInterface = DIContainer.shared.resolve(type: ChallengeInterface.self) ?? DefaultChallengeRepository(networkService: DefaultNetworkService()
        )
    ){
        self.challengeRepository = challengeRepository
    }
    
    var nextButtonState: ButtonState {
        selectedRoutine == nil ? .normal : .active
    }
    
    func select(_ routine: RoutineEntity) {
        selectedRoutine = routine
    }
    
    func fetchRoutines() {
        challengeRepository.fetchHomecareRoutines { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let routines):
                    self?.routines = routines
                case .failure(let error):
                    CherrishLogger.error(error)
                    self?.routines = []
                }
            }
        }
    }
}

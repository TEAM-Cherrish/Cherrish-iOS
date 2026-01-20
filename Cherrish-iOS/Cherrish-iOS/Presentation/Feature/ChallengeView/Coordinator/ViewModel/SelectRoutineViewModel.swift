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
    @Published private(set) var missions: [ChallengeMissionEntity] = []
    @Published var routines: [RoutineEntity] = []
    @Published var selectedRoutine: RoutineEntity?
    @Published var isloading: Bool = false
    
    private let fetchChallengeHomecareRoutines: FetchChllengeHomecareRoutinesUseCase
    private let submitChallengRecommendUseCase: SubmitChallengRecommendUseCase
    
    init(fetchChallengeHomecareRoutines: FetchChllengeHomecareRoutinesUseCase,submitChallengRecommendUseCase: SubmitChallengRecommendUseCase) {
        self.fetchChallengeHomecareRoutines = fetchChallengeHomecareRoutines
        self.submitChallengRecommendUseCase = submitChallengRecommendUseCase
    }
    
    var nextButtonState: ButtonState {
        selectedRoutine == nil ? .normal : .active
    }
    
    func select(_ routine: RoutineEntity) {
        selectedRoutine = routine
    }
    
    @MainActor
    func fetchRoutines() async {
        do {
            self.routines = try await fetchChallengeHomecareRoutines.excute()
        } catch {
            CherrishLogger.error(error)
            routines = []
        }
    }
    
    @MainActor
    func postChallengRecommend(id: Int) async {
        do {
            missions = try await submitChallengRecommendUseCase.excute(id: id)
        } catch {
            CherrishLogger.error(error)
            missions = []
        }
    }
}

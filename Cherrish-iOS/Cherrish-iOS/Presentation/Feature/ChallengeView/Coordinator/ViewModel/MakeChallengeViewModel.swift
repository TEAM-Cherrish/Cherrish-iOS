//
//  MakeChallengeViewModel.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/21/26.
//

import Foundation

final class MakeChallengeViewModel: ObservableObject {
    @Published private(set) var routines: [RoutineEntity] = []
    @Published var selectedRoutine: RoutineEntity?
    @Published var isLoading: Bool = false
    @Published private(set) var missions: [ChallengeMissionEntity] = []
    @Published var nextButtonState: ButtonState = .normal
    
    @Published var missonsSelectedState: [ChallengeMissionEntity: Bool] = [:]
    
    private let fetchRoutineUseCase: FetchChllengeHomecareRoutinesUseCase
    private let postChallengeRecommendUseCase: SubmitChallengRecommendUseCase
    
    init(
        fetchRoutineUseCase: FetchChllengeHomecareRoutinesUseCase,
        postChallengeRecommendUseCase: SubmitChallengRecommendUseCase
    ) {
        self.fetchRoutineUseCase = fetchRoutineUseCase
        self.postChallengeRecommendUseCase = postChallengeRecommendUseCase
    }
    
    @MainActor
    func fetchRoutines() async throws {
        routines = try await fetchRoutineUseCase.excute()
        CherrishLogger.debug("루틴 \(routines)")
    }
    
    func selectRoutine(id: Int) {
        guard let routine = routines.first(where: { $0.id == id }) else {
           selectedRoutine = nil
           nextButtonState = .normal
           return
       }

       selectedRoutine = routine
       nextButtonState = .active
    }
    
    @MainActor
    func postChallengeRecommend() async throws {
        guard let selectedRoutine else { return  }
        isLoading = true
        missions = try await postChallengeRecommendUseCase.excute(id: selectedRoutine.id)
        CherrishLogger.debug("뷰모델 미션 \(missions)")
    }
    
    func selectMission(mission: ChallengeMissionEntity) {
        missonsSelectedState[mission]?.toggle()
        CherrishLogger.debug("미션 체크 상태 \(missonsSelectedState)")
    }

    @MainActor
    func makeChallenge() async throws {
        
    }
}

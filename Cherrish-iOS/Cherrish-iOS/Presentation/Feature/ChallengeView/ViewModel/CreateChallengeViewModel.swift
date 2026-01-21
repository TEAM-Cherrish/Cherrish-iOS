//
//  MakeChallengeViewModel.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/21/26.
//

import Foundation

enum challengeViewState: StepNavigatable {
    case routine
    case loding
    case mission

    var title: String {
        switch self {
        case .routine:
            return "루틴 챌린지 선택"
        case .loding:
            return ""
        case .mission:
            return "TO-DO 미션 선택"
        }
    }

    var isLeftButton: Bool {
        return true
    }

    var isRightButton: Bool {
        switch self {
        case .routine:
            return true
        case .loding:
            return false
        case .mission:
            return true
        }
    }
}


final class CreateChallengeViewModel: ObservableObject {
    @Published var viewState: challengeViewState = .routine
    @Published private(set) var routines: [RoutineEntity] = []
    @Published var selectedRoutine: RoutineEntity?
    @Published var isLoading: Bool = false
    @Published private(set) var missions: [ChallengeMissionEntity] = []
    @Published var nextButtonState: ButtonState = .normal

    @Published var missonsSelectedState: [ChallengeMissionEntity: Bool] = [:]

    private let fetchRoutineUseCase: FetchChllengeHomecareRoutinesUseCase
    private let postChallengeRecommendUseCase: PostChallengeRecommendUseCase
    private let createChallengeUseCase: CreateChallengeUseCase

    init(
        fetchRoutineUseCase: FetchChllengeHomecareRoutinesUseCase,
        postChallengeRecommendUseCase: PostChallengeRecommendUseCase,
        createChallengeUseCase: CreateChallengeUseCase
    ) {
        self.fetchRoutineUseCase = fetchRoutineUseCase
        self.postChallengeRecommendUseCase = postChallengeRecommendUseCase
        self.createChallengeUseCase = createChallengeUseCase
    }

    @MainActor
    func fetchRoutines() async throws {
        routines = try await fetchRoutineUseCase.excute()
        CherrishLogger.debug("루틴 \(routines)")
    }

    func next() {
        viewState.next()
    }

    func previous() {
        viewState.previous()
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
        guard let selectedRoutine else { return }

        let selectedMissionList = missonsSelectedState
            .filter(\.value)
            .map(\.key.title)
        CherrishLogger.debug("선택한 미션들: \(selectedMissionList)")

        try await createChallengeUseCase.execute(id: selectedRoutine.id, routines: selectedMissionList)
    }
}

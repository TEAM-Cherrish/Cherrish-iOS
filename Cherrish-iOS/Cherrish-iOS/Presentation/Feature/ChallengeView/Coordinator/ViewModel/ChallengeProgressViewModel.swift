//
//  ChallengeProgressViewModel.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/21/26.
//

import Foundation

final class ChallengeProgressViewModel: ObservableObject {
    @Published private(set) var challengeData: ChallengeEntity?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let fetchChallengeUseCase: FetchChallengeUseCase
    private let toggleRoutineUseCase: ToggleRoutineUseCase
    private let advanceDayUseCase: AdvanceDayUseCase

    init(
        fetchChallengeUseCase: FetchChallengeUseCase,
        toggleRoutineUseCase: ToggleRoutineUseCase,
        advanceDayUseCase: AdvanceDayUseCase
    ) {
        self.fetchChallengeUseCase = fetchChallengeUseCase
        self.toggleRoutineUseCase = toggleRoutineUseCase
        self.advanceDayUseCase = advanceDayUseCase
    }

    @MainActor
    func loadChallenge() async {
        isLoading = true
        errorMessage = nil

        do {
            challengeData = try await fetchChallengeUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    @MainActor
    func toggleRoutine(routineID: Int) async {
        do {
            let updatedRoutine = try await toggleRoutineUseCase.execute(routineID: routineID)

            guard let currentData = challengeData else { return }

            let updatedRoutines = currentData.todayRoutines.map { routine in
                if routine.routineID == updatedRoutine.routineID {
                    return updatedRoutine
                }
                return routine
            }

            challengeData = ChallengeEntity(
                challengeID: currentData.challengeID,
                title: currentData.title,
                currentDay: currentData.currentDay,
                progressPercentage: currentData.progressPercentage,
                cherryLevel: currentData.cherryLevel,
                cherryLevelName: currentData.cherryLevelName,
                progressToNextLevel: currentData.progressToNextLevel,
                remainingRoutinesToNextLevel: currentData.remainingRoutinesToNextLevel,
                todayRoutines: updatedRoutines
            )
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    @MainActor
    func advanceDay() async {
        isLoading = true
        errorMessage = nil

        do {
            challengeData = try await advanceDayUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

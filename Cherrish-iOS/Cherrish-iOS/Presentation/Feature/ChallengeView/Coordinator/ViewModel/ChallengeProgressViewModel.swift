//
//  ChallengeProgressViewModel.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/21/26.
//

import Foundation

final class ChallengeProgressViewModel: ObservableObject {
    @Published private(set) var challengeData: ProgressChallengeEntity?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var cherryLevel: CherryLevel = .level1
    @Published private(set) var remainMissions: Int = 0
    @Published private(set) var progressRate = 0
    @Published private(set) var currentDay: Int = 1
    @Published private(set) var challengeTitle: String = ""
    @Published private(set) var todayRoutines: [ProgressRoutineEntity] = []
    
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
            updateInfo()
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

            challengeData = ProgressChallengeEntity(
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
            updateInfo()
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
        updateInfo()
    }
}

extension ChallengeProgressViewModel {
    var isChallengeCompleted: Bool {
        currentDay == 7
    }
    
    @MainActor
    private func updateInfo() {
        guard let challengeData else { return }
        cherryLevel =  CherryLevel.from(progressRate: Double(challengeData.progressPercentage))
        remainMissions = challengeData.remainingRoutinesToNextLevel
        progressRate = challengeData.progressPercentage
        currentDay = challengeData.currentDay
        challengeTitle = challengeData.title + " 챌린지"
        todayRoutines = challengeData.todayRoutines
    }
}

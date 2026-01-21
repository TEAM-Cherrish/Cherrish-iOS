//
//  DemoRepository.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/21/26.
//

import Foundation

struct DefaultDemoRepository: DemoInterface {
    private let networkService: NetworkService
    private let userDefaultService: UserDefaultService
    
    init(
        networkService: NetworkService,
        userDefaultService: UserDefaultService
    ) {
        self.networkService = networkService
        self.userDefaultService = userDefaultService
    }
    
    func fetchChallenges() async throws -> ProgressChallengeEntity {
        let userID: Int = userDefaultService.load(key: .userID) ?? 1
        let response = try await networkService.request(
            DemoAPI.fetchChallenges(userID: userID),
            decodingType: FetchChallengesResponseDTO.self
        )
        let _ = userDefaultService.save(true, key: .hasProgressChallenge)
        CherrishLogger.debug(userDefaultService.load(key: .hasProgressChallenge) ?? false)
        return response.toEntity()
    }
    
    func advance() async throws -> ProgressChallengeEntity {
        let userID: Int = userDefaultService.load(key: .userID) ?? 1
        do {
            let response = try await networkService.request(
                DemoAPI.advance(userID: userID),
                decodingType: FetchChallengesResponseDTO.self
            )
            return response.toEntity()
            
        } catch {
            if error as! CherrishError == CherrishError.conflict {
                let _ = userDefaultService.save(false, key: .hasProgressChallenge)
            }
            throw error
        }
        
    }
    
    func toggleRoutine(routineID: Int) async throws -> ProgressRoutineEntity {
        let userID: Int = userDefaultService.load(key: .userID) ?? 1
        let response = try await networkService.request(
            DemoAPI.routineToggle(userID: userID, routineID: routineID),
            decodingType: RoutineToggleResponseDTO.self
        )
        return response.toEntity()
    }
    
    func createChallenge(missionIds: Int, routineNames: [String]) async throws  {
        let userID: Int = userDefaultService.load(key: .userID) ?? 1
        let response = try await networkService.request(
            DemoAPI.createChallenge(userID: userID, requestDTO:
                    .init(
                        homecareRoutineId: missionIds,
                        routineNames: routineNames
                    )
            )
        )
    }
}

//
//  MyPageRepository.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/20/26.
//

import Foundation

struct DefaultMyPageRepository: MyPageInterface {
    private let networkService: NetworkService
    private let userDefaultService: UserDefaultService
    
    init(
        networkService: NetworkService,
        userDefaultService: UserDefaultService
    ) {
        self.networkService = networkService
        self.userDefaultService = userDefaultService
    }
    
    func fetchUserInfo() async throws -> UserInfoEntity {
        let userID: Int = userDefaultService.load(key: .userID) ?? 1
        let response = try await networkService.request(
            MyPageAPI.users(userID: userID),
            decodingType: UserInfoResponseDTO.self)
        
        return response.toEntity()
    }
}

//
//  FetchUserInfoUseCase.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/20/26.
//

import Foundation

protocol FetchUserInfoUseCase {
    func execute() async throws -> UserInfoEntity
}

struct DefaultFetchUserInfoUserCase: FetchUserInfoUseCase {
    private let repository: MyPageInterface
    
    init(repository: MyPageInterface) {
        self.repository = repository
    }
    
    func execute() async throws -> UserInfoEntity {
        return try await repository.fetchUserInfo()
    }
}

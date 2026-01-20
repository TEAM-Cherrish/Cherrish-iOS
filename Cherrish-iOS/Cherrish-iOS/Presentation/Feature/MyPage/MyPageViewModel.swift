//
//  MyPageViewModel.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/20/26.
//

import Foundation

final class MyPageViewModel: ObservableObject {
    @Published private(set) var name: String = ""
    @Published private(set) var day: Int = 1
    
    private let fetchUserInfoUseCase: FetchUserInfoUseCase
    
    init(fetchUserInfoUseCase: FetchUserInfoUseCase) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
    }
    
    func fetchUserInfo() async throws {
        let response = try await fetchUserInfoUseCase.execute()
        name = response.name
        day = response.daysSinceSignup
    }
}

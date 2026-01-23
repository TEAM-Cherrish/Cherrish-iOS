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
    @Published private(set) var isLoading: Bool = false
    
    private let fetchUserInfoUseCase: FetchUserInfoUseCase
    
    init(fetchUserInfoUseCase: FetchUserInfoUseCase) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
    }
    
    @MainActor
    func fetchUserInfo() async throws {
        isLoading = true
        
        do {
            let response = try await fetchUserInfoUseCase.execute()
            isLoading = false
            name = response.name
            day = response.daysSinceSignup
        } catch {
            CherrishLogger.error(error)
        }
    }
}

//
//  MyPageInterface.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/20/26.
//

import Foundation

protocol MyPageInterface {
    func fetchUserInfo() async throws -> UserInfoEntity
}

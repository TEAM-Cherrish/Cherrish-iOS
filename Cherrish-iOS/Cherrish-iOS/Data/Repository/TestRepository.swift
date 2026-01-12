//
//  Repository.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/3/26.
//

import Foundation

struct DefaultTestRepository: TestInterface {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func test() {
        print("Repository Test!")
    }
}

//
//  Usecase.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/3/26.
//

import Foundation

protocol TestUseCase {
    func execute()
}

struct DefaultTestUseCase: TestUseCase {
    private let repository: TestInterface
    
    init(repository: TestInterface) {
        self.repository = repository
    }
    
    func execute() {
        self.repository.test()
        print("UseCase execute")
    }
}

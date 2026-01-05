//
//  DataDependencyAssembler.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/5/26.
//

import Foundation

final class DataDependencyAssembler: DependencyAssembler {
    func assemble() {
        DIContainer.shared.register(type: TestInterface.self) { 
            return DefaultTestRepository()
        }
    }
}

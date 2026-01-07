//
//  AppDIContainer.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 12/31/25.
//

import Foundation

protocol DependencyAssembler {
    func assemble()
}

final class DIContainer {
    
    static let shared = DIContainer()
    
    private init() { }
    
    private var dependencies: [String: () -> Any] = [:]
    
    func register<T>(type: T.Type, closure: @escaping () -> T) {
        let key = String(describing: T.self)
        dependencies[key] = closure
    }
    
    func resolve<T>(type: T.Type) -> T? {
        let key = String(describing: T.self)
        guard let closure = dependencies[key] else {
            return nil
        }
        
        return closure() as? T
    }
}

//
//  AppDIContainer+.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/5/26.
//

import Foundation

extension DIContainer {
    func dependencyInjection() {
        let dataDependencyAssembler = DataDependencyAssembler()
        let domainDependencyAssembler = DomainDependencyAssembler(preAssembler: dataDependencyAssembler)
        let presentationDependencyAssembler = PresentationDependencyAssembler(preAssembler: domainDependencyAssembler)
        
        presentationDependencyAssembler.assemble()
    }
}

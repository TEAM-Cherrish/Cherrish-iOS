//
//  ViewFactory.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/5/26.
//

import Foundation

protocol ViewFactoryProtocol {
    static func makeTestView() -> TestView
}

final class ViewFactory: ViewFactoryProtocol {
    static func makeTestView() -> TestView {
        guard let viewModel = DIContainer.shared.resolve(type: TestViewModel.self) else {
            // TODO: DI 실패 시 기본으로 갈 곳 지정 
            fatalError()
        }
        return TestView(viewModel: viewModel)
    }
}

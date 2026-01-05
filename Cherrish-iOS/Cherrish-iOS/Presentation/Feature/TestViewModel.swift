//
//  TestViewModel.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/5/26.
//

import Foundation

final class TestViewModel: ObservableObject {
    @Published var text: String = "터치해보세여"
    private let testUseCase: TestUseCase
    
    init(testUseCase: TestUseCase) {
        self.testUseCase = testUseCase
    }
    
    func test() {
        testUseCase.execute()
        text = "버튼 터치했음!"
        print("view model execute")
    }
}

//
//  Cherrish_iOSApp.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 12/31/25.
//

import SwiftUI

@main
struct Cherrish_iOSApp: App {
    
    init() {
        // TODO: 코디네이터에서 실행하기
        DIContainer.shared.dependencyInjection()
    }
    
    var body: some Scene {
        WindowGroup {
            ViewFactory.makeTestView()
        }
    }
}

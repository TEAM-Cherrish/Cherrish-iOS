//
//  GradientBox.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/14/26.
//

import SwiftUI

struct GradientBox: View {
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [.gray00, .gray0]),
                                 startPoint: .top,
                                 endPoint: .bottom)
            )
    }
}

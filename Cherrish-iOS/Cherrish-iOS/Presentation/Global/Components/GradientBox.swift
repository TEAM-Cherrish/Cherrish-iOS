//
//  GradientBox.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/14/26.
//

import SwiftUI

struct GradientBox: View {
    let isTop: Bool
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: isTop ? Gradient(colors: [.gray0, .gray00]) : Gradient(colors: [.gray00, .gray0]),
                                 startPoint: .top,
                                 endPoint: .bottom)
            )
    }
}

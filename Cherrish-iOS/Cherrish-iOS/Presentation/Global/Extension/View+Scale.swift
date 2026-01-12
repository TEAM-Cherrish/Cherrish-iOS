//
//  View+Scale.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/12/26.
//

import SwiftUI

extension View {
    func scaleX(_ scale: CGFloat) -> some View {
        self.scaleEffect(x: scale, y: 1, anchor: .leading)
    }
}

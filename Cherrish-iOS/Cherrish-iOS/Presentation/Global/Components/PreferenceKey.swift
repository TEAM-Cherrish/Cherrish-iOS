//
//  PreferenceKey.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/14/26.
//

import SwiftUI

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    } 
}

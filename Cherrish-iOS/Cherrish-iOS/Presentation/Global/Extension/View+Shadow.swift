//
//  View+Shadow.swift
//  Cherrish-iOS
//

import SwiftUI

struct CherrishShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(
                color: Color(.shadow),
                radius: 10,
                x: 0,
                y: 0
            )
    }
}

extension View {
    func cherrishShadow() -> some View {
        self.modifier(CherrishShadow())
    }
}

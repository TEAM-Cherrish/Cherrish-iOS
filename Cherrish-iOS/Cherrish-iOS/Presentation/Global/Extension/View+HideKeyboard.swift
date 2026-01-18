//
//  View+HideKeyboard.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/19/26.
//

import SwiftUI

extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

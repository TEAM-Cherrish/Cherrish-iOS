//
//  CustomNavigationBar.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/9/26.
//

import SwiftUI

struct CustomNavigationBar: View {
    let isDisplayLeftBtn: Bool
    let isDisplayRightBtn: Bool
    let title: String
    let leftBtnAction: () -> Void
    let rightBtnAction: () -> Void
    
    init(isDisplayLeftBtn: Bool = true,
         isDisplayRightBtn: Bool = true,
         title: String = "",
         leftBtnAction: @escaping () -> Void = {},
         rightBtnAction: @escaping () -> Void = {},
    ) {
        self.isDisplayLeftBtn = isDisplayLeftBtn
        self.isDisplayRightBtn = isDisplayRightBtn
        self.title = title
        self.leftBtnAction = leftBtnAction
        self.rightBtnAction = rightBtnAction
    }
    
    var body: some View {
        HStack {
            
            Spacer()
            Text(title)
            Spacer()
            
        }
    }
}

#Preview {
    CustomNavigationBar(title: "안녕")
}

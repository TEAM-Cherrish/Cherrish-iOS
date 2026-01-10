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
        ZStack {
            HStack(spacing: 0) {
                if isDisplayLeftBtn {
                    Image(.chevronLeft)
                        .padding(10)
                        .onTapGesture {
                            leftBtnAction()
                        }
                }
                
                Spacer()
                
                if isDisplayRightBtn {
                    Image(.close)
                        .padding(10)
                        .onTapGesture {
                            rightBtnAction()
                        }
                }
            }
            HStack {
                Spacer()
                Text(title)
                    .typography(.title1_sb_18)
                Spacer()
            }
            
        }
        .frame(height: 44)
        .padding(.vertical,8)
        
    }
}

#Preview {
    CustomNavigationBar(
        isDisplayLeftBtn: true,
        isDisplayRightBtn: true,
        title: "시술 여부 선택",
        leftBtnAction: { print("왼쪽 클릭") },
        rightBtnAction: { print("오른쪽 클릭") }
    )
    
}

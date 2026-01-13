//
//  CherrishNavigationBar.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/9/26.
//

import SwiftUI

struct CherrishNavigationBar: View {
    let isDisplayLeftButton: Bool
    let isDisplayRightButton: Bool
    let title: String
    let leftButtonAction: () -> Void
    let rightButtonAction: () -> Void
    
    init(isDisplayLeftButton: Bool = true,
         isDisplayRightButton: Bool = true,
         title: String = "",
         leftButtonAction: @escaping () -> Void = {},
         rightButtonAction: @escaping () -> Void = {}
    ) {
        self.isDisplayLeftButton = isDisplayLeftButton
        self.isDisplayRightButton = isDisplayRightButton
        self.title = title
        self.leftButtonAction = leftButtonAction
        self.rightButtonAction = rightButtonAction
    }
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                if isDisplayLeftButton {
                    Image(.chevronLeft)
                        .padding(10)
                        .onTapGesture {
                            leftButtonAction()
                        }
                }
                
                Spacer()
                
                if isDisplayRightButton {
                    Image(.close)
                        .padding(10)
                        .onTapGesture {
                            rightButtonAction()
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
        .frame(height: 44.adjustedH)
        .padding(.vertical, 8.adjustedH)
        
    }
}


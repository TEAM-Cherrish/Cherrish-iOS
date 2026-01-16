//
//  InformationView.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/15/26.
//

import SwiftUI

struct InformationView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @EnvironmentObject private var onboardingCoordinator: OnboardingCoordinator
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    @State var name = ""
    @State var age = ""
    @State private var buttonState: ButtonState = .normal

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TypographyText("이름과 나이를 입력해주세요.", style: .title1_sb_18, color: .gray1000)
                
                Spacer()
            }
            .padding(.leading, 34)
            .padding(.top, 143)
            
            HStack(spacing: 0) {
                TypographyText("회복가이드를 위해 기본 정보가 필요해요!", style: .title2_m_16, color: .gray700)
                
                Spacer()
            }
            .padding(.leading, 34)
            .padding(.top, 6)
            
            CherrishTextBox(title: "이름",text: $name, placeholder: "김체리")
                .padding(.top, 70)
                .padding(.horizontal, 34)
            
            CherrishTextBox(title: "나이",text: $age, placeholder: "20", isNumberField: true)
                .padding(.top, 30)
                .padding(.horizontal, 34)

            Spacer()
            
            CherrishButton(title: "다음", type: .next, state: $buttonState) {
                appCoordinator.navigationToTabbar()
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 38)
        }
        .onChange(of: name) { _ in updateButtonState() }
        .onChange(of: age) { _ in updateButtonState() }
    }
    
    private func updateButtonState() {
        buttonState = (!name.isEmpty && !age.isEmpty) ? .active : .normal
    }
}

#Preview {
    InformationView(viewModel: OnboardingViewModel())
}

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
    
    @State private var name = ""
    @State private var age = ""
    @State private var buttonState: ButtonState = .normal
    @FocusState private var isNameFocused: Bool
    @FocusState private var isAgeFocused: Bool
    @State private var showAgeError: Bool = false
    
    private var isNameOverLimit: Bool {
        name.count > 7
    }
    
    private var ageNumericValue: Int? {
        let numericString = age.replacingOccurrences(of: " 세", with: "")
        return Int(numericString)
    }
    
    private var isAgeOverLimit: Bool {
        guard let ageValue = ageNumericValue else { return false }
        return ageValue > 100
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TypographyText("이름과 나이를 입력해주세요.", style: .title1_sb_18, color: .gray1000)
                
                Spacer()
            }
            .padding(.leading, 34.adjustedW)
            .padding(.top, 143.adjustedH)
            
            HStack(spacing: 0) {
                TypographyText("회복가이드를 위해 기본 정보가 필요해요!", style: .title2_m_16, color: .gray700)
                
                Spacer()
            }
            .padding(.leading, 34.adjustedW)
            .padding(.top, 6.adjustedH)
            
            CherrishTextBox(title: "이름",text: $name, placeholder: "김체리")
                .focused($isNameFocused)
                .overlay(alignment: .bottomLeading) {
                    if isNameOverLimit {
                        TypographyText("이름은 최대 7자까지 입력 가능합니다.", style: .body1_r_14, color: .red700)
                            .offset(y: 24.adjustedH)
                    }
                }
                .padding(.top, 70.adjustedH)    
                .padding(.horizontal, 34.adjustedW)
            
            CherrishTextBox(title: "나이",text: $age, placeholder: "20 세", isNumberField: true)
                .focused($isAgeFocused)
                .overlay(alignment: .bottomLeading) {
                    if showAgeError {
                        TypographyText("입력 가능한 최대 나이 100세를 초과했습니다.", style: .body1_r_14, color: .red700)
                            .offset(y: 24.adjustedH)
                    }
                }
                .padding(.top, 35.adjustedH)
                .padding(.horizontal, 34.adjustedW)

            Spacer()
            
            CherrishButton(
                title: "다음",
                type: .large,
                state: $buttonState,
                leadingIcon: nil,
                trailingIcon: nil
            ) {
                Task {
                    guard let ageValue = ageNumericValue else { return }
                    await viewModel.createProfile(name: name, age: ageValue)
                }
            }
            .disabled(viewModel.isLoading)
            .padding(.horizontal, 25.adjustedW)
            .padding(.bottom, 38.adjustedH)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isNameFocused = false
            isAgeFocused = false
        }
        .onChange(of: name) { _ in updateButtonState() }
        .onChange(of: age) { _ in updateButtonState() }
        .onChange(of: isAgeFocused) { focused in
            if !focused {
                if let numericValue = ageNumericValue, !age.hasSuffix(" 세") {
                    age = "\(numericValue) 세"
                }
                showAgeError = isAgeOverLimit
            }
        }
        .onChange(of: viewModel.isOnboardingCompleted) { completed in
            if completed {
                appCoordinator.navigationToTabbar()
            }
        }
    }
    
    private func updateButtonState() {
        let isNameValid = !name.isEmpty && !isNameOverLimit
        let isAgeValid = !age.isEmpty && !isAgeOverLimit
        buttonState = (isNameValid && isAgeValid) ? .active : .normal
    }
}

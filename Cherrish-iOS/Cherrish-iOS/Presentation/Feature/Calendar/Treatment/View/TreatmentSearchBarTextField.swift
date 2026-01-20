//
//  TreatmentSearchBarTextField.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import SwiftUI

struct TreatmentSearchBarTextField: View {
    @Binding var text: String
    let onTap: () -> Void
    var isDisabled: Bool
    var body: some View {
        
        VStack {
            HStack{
                ZStack {
                    if text.isEmpty {
                        HStack{
                            TypographyText("원하시는 시술을 적어주세요.", style: .body1_r_14, color: .gray600)
                            
                            Spacer()
                            
                        }
                    }
                    TextField("" ,text: $text)
                        .foregroundStyle(.gray1000)
                        .typography(.body1_m_14)
                        .multilineTextAlignment(.leading)
                        .tint(.gray1000)
                        .onSubmit {
                            onTap()
                        }
                }
                .frame(height: 20.adjustedH)
                .padding(.vertical, 8.adjustedH)
                
                Button{
                    onTap()
                } label: {
                    ZStack {
                        Image(.search)
                    }
                }
                .padding(.leading, 8.adjustedW)
                .disabled(isDisabled)
            }
        }
        .padding(.horizontal, 16.5.adjustedW)
        .background{
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(.gray200)
        }
    }
}

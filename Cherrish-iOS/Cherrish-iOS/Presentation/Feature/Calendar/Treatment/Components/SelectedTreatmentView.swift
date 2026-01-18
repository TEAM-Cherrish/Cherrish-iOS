//
//  SelectedTreatmentView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import SwiftUI

struct SelectedTreatmentView: View {
    let selectedTreatments: [TreatmentEntity]
    let removeTreatment: (TreatmentEntity) -> Void
    
    private let itemHeight: CGFloat = 34.adjustedH
    private let spacing: CGFloat = 16.adjustedH
    private let maxVisibleCount = 3
    
    private var scrollViewHeight: CGFloat {
        let count = min(selectedTreatments.count, maxVisibleCount)
        let contentHeight = CGFloat(count) * itemHeight + CGFloat(max(count - 1, 0)) * spacing
        return contentHeight + 24.adjustedH
    }
    
    @State private var topGlobalY: CGFloat = .zero
    @State private var initialTopGlobalY: CGFloat? = nil
    @State private var bottomOffsetY: CGFloat = .zero
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    TypographyText("선택한 시술", style: .body1_sb_14, color: .gray600)
                    
                    Spacer()
                    
                }
                .padding(.horizontal, 26.adjustedW)
                .padding(.vertical, 9.adjustedH)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray400)
                
            }
            .background(.gray0)
            .cornerRadius(10, corners: [.topLeft, .topRight])
            .shadow(
                color: .gray500.opacity(0.12),
                radius: 5,
                x: 0,
                y: -5
            )
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: spacing) {
                        scrollViewTopMarkerView
                            .allowsHitTesting(false)
                        
                        ForEach(selectedTreatments, id: \.id) { treatment in
                            TreatmentRowView(
                                displayMode: .summary,
                                treatmentEntity: treatment,
                                isSelected: .constant(true),
                                action: { removeTreatment(treatment) }
                            )
                            .frame(height: itemHeight)
                        }
                        
                        scrollViewBottomMarkerView
                            .allowsHitTesting(false)
                    }
                    .padding(.vertical, 14.adjustedH)
                }
                
                GradientBox(isTop: true)
                    .frame(height: 42)
                    .allowsHitTesting(false)
                    .opacity(shouldShowGradientTop ? 1 : 0)
                    .frame(maxHeight: .infinity, alignment: .top)
                
                GradientBox(isTop: false)
                    .frame(height: 42)
                    .allowsHitTesting(false)
                    .opacity(shouldShowGradientBottom ? 1 : 0)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .frame(height: scrollViewHeight)
            .scrollDisabled(selectedTreatments.count <= maxVisibleCount)
            .padding(.horizontal, 24.5.adjustedW)
            .coordinateSpace(name: "SelectedTreatmentScroll")
            .onPreferenceChange(ScrollTopPreferenceKey.self) { minY in
                if initialTopGlobalY == nil { initialTopGlobalY = minY }
                topGlobalY = minY
            }
            .onPreferenceChange(ScrollBottomPreferenceKey.self) { height in
                bottomOffsetY = height  
            }
        }
    }
}

extension SelectedTreatmentView {
    private var scrollViewTopMarkerView: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: ScrollTopPreferenceKey.self,
                    value: proxy.frame(in: .named("SelectedTreatmentScroll")).minY
                )
        }
        .frame(height: 0)
    }
    
    private var scrollViewBottomMarkerView: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: ScrollBottomPreferenceKey.self,
                    value: proxy.frame(in: .named("SelectedTreatmentScroll")).maxY
                )
        }
        .frame(height: 0)
    }
    
    private var shouldShowGradientTop: Bool {
        guard selectedTreatments.count > maxVisibleCount else { return false }
        guard let initial = initialTopGlobalY else { return false }
        return topGlobalY < initial - 1
    }
    
    private var shouldShowGradientBottom: Bool {
        let remaining = bottomOffsetY - scrollViewHeight.adjustedH
        return remaining > 1
    }
}

#Preview {
    SelectedTreatmentView(selectedTreatments: [TreatmentEntity.init(name: "냐냐냐", benefits: ["냐냐냐"], downtimeMin: 3, downtimeMax: 5),TreatmentEntity.init(name: "냐냐냐", benefits: ["냐냐냐"], downtimeMin: 3, downtimeMax: 5),TreatmentEntity.init(name: "냐냐냐", benefits: ["냐냐냐"], downtimeMin: 3, downtimeMax: 5),TreatmentEntity.init(name: "냐냐냐", benefits: ["냐냐냐"], downtimeMin: 3, downtimeMax: 5),TreatmentEntity.init(name: "냐냐냐", benefits: ["냐냐냐"], downtimeMin: 3, downtimeMax: 5)], removeTreatment: { _ in})
}

//
//  SelectedTreatmentView.swift
//  Cherrish-iOS
//
//  Created by 어재선 on 1/16/26.
//

import SwiftUI

struct SelectedTreatmentSheetView: View {
    let selectedTreatments: [TreatmentEntity]
    let removeTreatment: (TreatmentEntity) -> Void
    
    private let itemHeight: CGFloat = 34.adjustedH
    private let spacing: CGFloat = 8.adjustedH
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
                        .frame(height: 20.adjustedH)
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
                        if selectedTreatments.count > 3 {
                            scrollViewTopMarkerView
                                .allowsHitTesting(false)
                        }
                        ForEach(selectedTreatments, id: \.id) { treatment in
                            TreatmentRowView(
                                displayMode: .summary,
                                treatmentEntity: treatment,
                                isSelected: .constant(true),
                                action: { removeTreatment(treatment) }
                            )
                            .frame(height: itemHeight)
                        }
                        if selectedTreatments.count > 3 {
                            scrollViewBottomMarkerView
                                .allowsHitTesting(false)
                        }
                    }
                    .padding(.vertical, 14.adjustedH)
                }
                if selectedTreatments.count > 3 {
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
                    
                
                
            }
            .frame(height: scrollViewHeight)
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

extension SelectedTreatmentSheetView {
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

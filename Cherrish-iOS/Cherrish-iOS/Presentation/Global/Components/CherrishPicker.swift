//
//  CherrishPicker.swift
//  Cherrish-iOS
//
//  Created by 송성용 on 1/14/26.
//

import SwiftUI
import UIKit

struct CherrishPicker: View {
    @Binding var selection: Int
    var range: ClosedRange<Int> = 0...30
    var width: CGFloat = 74.adjustedW

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray300)
                .frame(width: width, height: 44.adjustedH)
            
            PickerViewRepresentable(selection: $selection, range: range)
                .frame(width: width + 20.adjustedW, height: 132.adjustedH)
        }
        .frame(width: width, height: 132.adjustedH)
        .clipped()
    }
}

private struct PickerViewRepresentable: UIViewRepresentable {
    @Binding var selection: Int
    let range: ClosedRange<Int>
    
    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        
        picker.subviews.forEach { subview in
            subview.backgroundColor = .clear
        }
        
        let row = selection - range.lowerBound
        picker.selectRow(row, inComponent: 0, animated: false)
        
        DispatchQueue.main.async {
            self.findAndConnectScrollViews(in: picker, coordinator: context.coordinator)
        }
        
        return picker
    }
    
    private func findAndConnectScrollViews(in view: UIView, coordinator: Coordinator) {
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                coordinator.originalScrollViewDelegate = scrollView.delegate
                scrollView.delegate = coordinator
            }
            findAndConnectScrollViews(in: subview, coordinator: coordinator)
        }
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        guard !context.coordinator.isScrolling else { return }
        
        let row = selection - range.lowerBound
        if uiView.selectedRow(inComponent: 0) != row {
            uiView.selectRow(row, inComponent: 0, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension PickerViewRepresentable {
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate {
        var parent: PickerViewRepresentable
        private let rowHeight: CGFloat = 44.adjustedH
        var isScrolling: Bool = false
        weak var originalScrollViewDelegate: UIScrollViewDelegate?
        
        init(_ parent: PickerViewRepresentable) {
            self.parent = parent
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            parent.range.count
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            isScrolling = false
            parent.selection = parent.range.lowerBound + row
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            pickerView.subviews.forEach { subview in
                subview.backgroundColor = .clear
            }
            
            let label = (view as? UILabel) ?? UILabel()
            label.text = "\(parent.range.lowerBound + row)"
            label.textAlignment = .center
            label.font = UIFont(name: PretendardWeight.medium.rawValue, size: 18)
            label.textColor = UIColor(.gray1000)
            return label
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            44.adjustedH
        }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            60.adjustedW
        }
        
        private var initialContentOffset: CGFloat = 0
        private var initialRow: Int = 0
        
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            isScrolling = true
            initialContentOffset = scrollView.contentOffset.y
            initialRow = parent.selection - parent.range.lowerBound
            originalScrollViewDelegate?.scrollViewWillBeginDragging?(scrollView)
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            originalScrollViewDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            originalScrollViewDelegate?.scrollViewDidEndDecelerating?(scrollView)
        }
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            originalScrollViewDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            originalScrollViewDelegate?.scrollViewDidScroll?(scrollView)
            
            guard isScrolling else { return }
            
            let deltaOffset = scrollView.contentOffset.y - initialContentOffset
            let deltaRow = Int(round(deltaOffset / rowHeight))
            let newRow = initialRow + deltaRow
            let clampedRow = max(0, min(newRow, parent.range.count - 1))
            let newSelection = parent.range.lowerBound + clampedRow
            
            if parent.selection != newSelection {
                parent.selection = newSelection
            }
        }
        
        func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
            originalScrollViewDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
        }
    }
}

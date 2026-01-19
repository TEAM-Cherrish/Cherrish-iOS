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
    let range: ClosedRange<Int>
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
        picker.selectRow(row, inComponent: 0, animated: true)
        
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
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
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        var parent: PickerViewRepresentable
        
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
    }
}

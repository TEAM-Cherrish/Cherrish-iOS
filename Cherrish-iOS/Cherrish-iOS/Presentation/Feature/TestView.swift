//
//  ContentView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 12/31/25.
//

import SwiftUI

struct TestView: View {
    @ObservedObject var viewModel: TestViewModel
    
    var body: some View {
        VStack {
            Button(action:  {
                viewModel.test()
            }) {
                Text("\(viewModel.text)")
            }
            .padding()
        }
    }
}

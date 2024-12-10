//
//  MainCalculatorView.swift
//  Calculator
//
//  Created by joe on 12/10/24.
//

import SwiftUI

struct MainCalculatorView: View {
    @State private var lightMode: Bool = true
    @State private var currentComputation: String = ""
    @State private var mainResult: String = "0"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    MainCalculatorView()
}

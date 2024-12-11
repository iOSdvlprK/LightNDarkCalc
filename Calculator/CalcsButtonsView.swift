//
//  CalcsButtonsView.swift
//  Calculator
//
//  Created by joe on 12/11/24.
//

import SwiftUI

struct CalcsButtonsView: View {
    @Binding var currentComputation: String
    @Binding var mainResult: String
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    CalcsButtonsView(currentComputation: .constant("5+1"), mainResult: .constant("6"))
}

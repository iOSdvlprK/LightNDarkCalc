//
//  ComputationView.swift
//  Calculator
//
//  Created by joe on 12/11/24.
//

import SwiftUI

struct ComputationView: View {
    let currentComputation: String
    let mainResult: String
    
    var body: some View {
        VStack {
            Text(currentComputation)
            Text(mainResult)
        }
    }
}

#Preview {
    ComputationView(currentComputation: "5+1", mainResult: "6")
}

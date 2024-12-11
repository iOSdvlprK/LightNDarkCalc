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
        ZStack {
            primaryBackgroundColor
                .ignoresSafeArea()
            
            VStack {
                SunMoonView(lightMode: lightMode)
                    .onTapGesture {
                        withAnimation {
                            lightMode.toggle()
                        }
                    }
                
                Spacer()
                
                ComputationView(currentComputation: currentComputation, mainResult: mainResult)
                
                Spacer()
                
                CalcsButtonsView(currentComputation: $currentComputation, mainResult: $mainResult)
            }
            .padding()
        }
        .environment(\.colorScheme, lightMode ? .light : .dark)
    }
}

#Preview {
    MainCalculatorView()
}

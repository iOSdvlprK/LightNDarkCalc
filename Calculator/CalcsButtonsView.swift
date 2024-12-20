//
//  CalcsButtonsView.swift
//  Calculator
//
//  Created by joe on 12/11/24.
//

import SwiftUI

struct CalcButtonModel: Identifiable {
    let id = UUID()
    let calcButton: CalcButton
    var color: Color = foregroundDigitsColor
}

struct RowOfCalcButtonsModel: Identifiable {
    let id = UUID()
    let row: [CalcButtonModel]
}

struct CalcsButtonsView: View {
    @Binding var currentComputation: String
    @Binding var mainResult: String
    
    let buttonData: [RowOfCalcButtonsModel] = [
        RowOfCalcButtonsModel(row: [
            CalcButtonModel(calcButton: .clear, color: foregroundTopButtonsColor),
            CalcButtonModel(calcButton: .negative, color: foregroundTopButtonsColor),
            CalcButtonModel(calcButton: .percent, color: foregroundTopButtonsColor),
            CalcButtonModel(calcButton: .divide, color: foregroundRightButtonsColor)
        ]),
        RowOfCalcButtonsModel(row: [
            CalcButtonModel(calcButton: .seven),
            CalcButtonModel(calcButton: .eight),
            CalcButtonModel(calcButton: .nine),
            CalcButtonModel(calcButton: .multiply, color: foregroundRightButtonsColor)
        ]),
        RowOfCalcButtonsModel(row: [
            CalcButtonModel(calcButton: .four),
            CalcButtonModel(calcButton: .five),
            CalcButtonModel(calcButton: .six),
            CalcButtonModel(calcButton: .subtract, color: foregroundRightButtonsColor)
        ]),
        RowOfCalcButtonsModel(row: [
            CalcButtonModel(calcButton: .one),
            CalcButtonModel(calcButton: .two),
            CalcButtonModel(calcButton: .three),
            CalcButtonModel(calcButton: .add, color: foregroundRightButtonsColor)
        ]),
        RowOfCalcButtonsModel(row: [
            CalcButtonModel(calcButton: .undo),
            CalcButtonModel(calcButton: .zero),
            CalcButtonModel(calcButton: .decimal),
            CalcButtonModel(calcButton: .equal, color: foregroundRightButtonsColor)
        ])
    ]
    
    var body: some View {
        Grid {
            ForEach(buttonData) { rowOfCalcButtonsModel in
                GridRow {
                    ForEach(rowOfCalcButtonsModel.row) { calcButtonModel in
                        Button(
                            action: {
                                // logic takes place here
                                buttonPressed(calcButton: calcButtonModel.calcButton)
                            },
                            label: {
                                ButtonView(
                                    calcButton: calcButtonModel.calcButton,
                                    fgColor: calcButtonModel.color,
                                    bgColor: buttonBackgroundColor
                                )
                        })
                    }
                }
            }
        }
        .padding()
        .background(secondaryBackgroundColor.cornerRadius(20))
    }
    
    func buttonPressed(calcButton: CalcButton) {
        // logic
        switch calcButton {
        case .clear:
            currentComputation = ""
            mainResult = "0"
        case .equal, .negative:
            if !currentComputation.isEmpty {
                if !lastCharacterIsAnOperator(str: currentComputation) {
                    let sign = calcButton == .negative ? -1.0 : 1.0
                    
                    mainResult = formatResult(val: sign * calculateResults())
                    
                    if calcButton == .negative {
                        currentComputation = mainResult
                    }
                }
            }
        case .decimal:
            if let lastOccurenceOfDecimal = currentComputation.lastIndex(of: ".") {
                if lastCharIsDigit(str: currentComputation) {
                    let startIndex = currentComputation.index(lastOccurenceOfDecimal, offsetBy: 1)
                    let endIndex = currentComputation.endIndex
                    let range = startIndex..<endIndex
                    
                    let rightSubString = String(currentComputation[range])
                    
                    // Only have digits to the right "."
                    // that means do not add another "."
                    // otherwise we can add another decimal point
                    
                    // 23.37+108 Good -> 23.37+108.
                    // 123.45 Bad -> remains 123.45
                    if Int(rightSubString) == nil && !rightSubString.isEmpty {
                        currentComputation += "."
                    }
                }
            } else {
                if currentComputation.isEmpty {
                    currentComputation += "0."
                } else if lastCharIsDigit(str: currentComputation) {
                    currentComputation += "."
                }
            }
        case .percent:
            if lastCharIsDigit(str: currentComputation) {
                appendToCurrentComputation(calcButton: calcButton)
            }
        case .undo:
            currentComputation = String(currentComputation.dropLast())
        case .add, .subtract, .multiply, .divide:
            // Needs further implementation
            if lastCharIsDigitOrPercent(str: currentComputation) {
                appendToCurrentComputation(calcButton: calcButton)
            }
        default:
            // Needs further implementation
            appendToCurrentComputation(calcButton: calcButton)
        }
    }
    
    // Implements the actual computation
    func calculateResults() -> Double {
        let visibleWorkings: String = currentComputation
        var workings = visibleWorkings.replacingOccurrences(of: "%", with: "*0.01")
        workings = workings.replacingOccurrences(of: multiplySymbol, with: "*")
        workings = workings.replacingOccurrences(of: divisionSymbol, with: "/")
        
        // If we have "35.", this will be replaced by "35.0"
        if getLastChar(str: visibleWorkings) == "." {
            workings += "0"
        }
        
        // actual computation
        let expr = NSExpression(format: workings)
        let exprValue = expr.expressionValue(with: nil, context: nil) as! Double
        
        return exprValue
    }
    
    func appendToCurrentComputation(calcButton: CalcButton) {
        currentComputation += calcButton.rawValue
    }
}

#Preview {
    CalcsButtonsView(currentComputation: .constant("5+1"), mainResult: .constant("6"))
}

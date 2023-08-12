//
//  CalculatorViewModel.swift
//  ArithmeticCalculatorWithSwiftUI
//
//  Created by Roro Solutions LLP on 06/08/23.
//

import SwiftUI

protocol CalculatorViewModelProtocol: ObservableObject {
    func didTap(button: CalcButton)
    var resultValueDisplayed: String { get set }
    var expressionOfCalculations: String { get set }
}

class CalculatorViewModel: CalculatorViewModelProtocol {
    
    private var runningNumberValue = 0.0
    private var currentArithmeticOperation: ArithmeticOperation = .none
    private var isArithmeticOperationButtonTapped = false
    
    @Published var resultValueDisplayed = "0"
    // this is used to show the result value and show output what we tapped with calc buttons
    
    @Published var expressionOfCalculations = ""
    // this is used to show the complete expressions value of calculations and show output what we tapped with calc buttons, numbers buttons  etc.

    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .mutliply, .divide:
                didTapArithmeticOperator(button: button)
            print("didTapArithmeticOperator")
        case .equal:
               didTapEqualOperator()
            print("didTapEqualOperator")
        case .clear:
               didTapClearExpression()
            print("didTapClearExpression")
        case .decimal:
               didTapDecimalOperator()
            print("didTapDecimalOperator")
        case .percent:
               didTapPercentOperator()
            print("didTapPercentOperator")
        case .negative:
              didTapPlusMinusSign()
            print("didTapPlusMinusSign")
        default:
              didTapNumberValue(button: button)
            print("didTapNumberValue")
        }
        print("DidTap \(resultValueDisplayed) \(expressionOfCalculations)")
    }
    
    private func didTapEqualOperator() {
        // didTapEqualOperator
        let runningValue = self.runningNumberValue
        let currentValue = Double(self.resultValueDisplayed) ?? 0.0
        self.isArithmeticOperationButtonTapped = false
        let result:Double
        switch self.currentArithmeticOperation {
        case .add: result = runningValue + currentValue
        case .subtract: result = runningValue - currentValue
        case .multiply: result = runningValue * currentValue
        case .divide: result = runningValue / currentValue
        case .none: result = currentValue
        }
        self.resultValueDisplayed = result.ridZero()
 
        expressionOfCalculations = "\(self.expressionOfCalculations)=\(self.resultValueDisplayed)"
    }
    
    private func didTapPercentOperator() {
        // didTapPercentOperator
        if isResultNotContainsArithmeticOperatorSymbol() {
            let result = (Double(self.resultValueDisplayed) ?? 0.0) / 100.0
            self.resultValueDisplayed = result.ridZero()
            self.expressionOfCalculations = "\(self.expressionOfCalculations)/100 = \(self.resultValueDisplayed)"
        }
    }
    
    private func didTapPlusMinusSign() {
        // didTapPlusMinusSign
        if isResultNotContainsArithmeticOperatorSymbol() {
            let valueBeforeNegative = Double(self.resultValueDisplayed) ?? 0.0
            let result = valueBeforeNegative * -1
            self.resultValueDisplayed = result.ridZero()
            self.expressionOfCalculations = "\(self.expressionOfCalculations)x-1 = \(self.resultValueDisplayed)"
        }
    }
    
    private func didTapClearExpression() {
        // didTapClearExpression
        self.resultValueDisplayed = "0"
        self.expressionOfCalculations = ""
        self.isArithmeticOperationButtonTapped = false
    }
    
    private func didTapDecimalOperator() {
        // didTapDecimalOperator
        if isResultNotContainsArithmeticOperatorSymbol() {
            if self.resultValueDisplayed.contains(".") {
                // dont do anything
            } else {
                self.resultValueDisplayed = "\(self.resultValueDisplayed)."
                self.expressionOfCalculations = "\(self.expressionOfCalculations)."
            }
        } else {
            self.resultValueDisplayed = "."
            self.expressionOfCalculations = "\(self.expressionOfCalculations)."
        }
    }
    
    private func didTapNumberValue(button: CalcButton) {
        // didTapNumberValue
        let number = button.rawValue
        if self.isArithmeticOperationButtonTapped == true {
            if isResultNotContainsArithmeticOperatorSymbol() {
                self.resultValueDisplayed = "\(self.resultValueDisplayed)\(number)"
            } else {
                self.resultValueDisplayed = number
            }
        }
        else {
            if self.resultValueDisplayed != "0" {
                self.resultValueDisplayed = "\(self.resultValueDisplayed)\(number)"
            } else {
                self.resultValueDisplayed = number
            }
        }
        self.expressionOfCalculations = "\(self.expressionOfCalculations)\(number)"
    }
    
    private func didTapArithmeticOperator(button: CalcButton) {
        // didTapArithmeticOperator
        if isArithmeticOperationButtonTapped {
            didTap(button: .equal)
        }
        self.isArithmeticOperationButtonTapped = true
        self.runningNumberValue = Double(self.resultValueDisplayed) ?? 0.0
        if button == .add {
            self.currentArithmeticOperation = .add
        }
        else if button == .subtract {
            self.currentArithmeticOperation = .subtract
        }
        else if button == .mutliply {
            self.currentArithmeticOperation = .multiply
        }
        else if button == .divide {
            self.currentArithmeticOperation = .divide
        }
        if expressionOfCalculations.last != button.rawValue.last {
            self.resultValueDisplayed = "\(button.rawValue)"
            self.expressionOfCalculations = "\(self.expressionOfCalculations)\(String(describing: button.rawValue))"
        }
    }
    
    private func isResultNotContainsArithmeticOperatorSymbol() -> Bool {
        // isResultNotContainsArithmeticOperatorSymbol
        if self.resultValueDisplayed != "+" && self.resultValueDisplayed != "-" && self.resultValueDisplayed != "/" && self.resultValueDisplayed != "x" && self.resultValueDisplayed != "÷" {
            return true
        } else {
            return false
        }
    }
}

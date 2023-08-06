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
    @Published var expressionOfCalculations = ""
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .mutliply, .divide, .equal:
            if isArithmeticOperationButtonTapped && (button == .add || button == .divide || button == .mutliply || button == .subtract) {
                didTap(button: .equal)
            }
            if button == .add {
                self.currentArithmeticOperation = .add
                self.runningNumberValue = Double(self.resultValueDisplayed) ?? 0.0
                self.isArithmeticOperationButtonTapped = true
                self.resultValueDisplayed = "\(self.resultValueDisplayed)+"
                if expressionOfCalculations.last != "+" {
                    self.resultValueDisplayed = "+"
                    self.expressionOfCalculations = "\(self.expressionOfCalculations)+"
                }
                
            }
            else if button == .subtract {
                self.currentArithmeticOperation = .subtract
                self.runningNumberValue = Double(self.resultValueDisplayed) ?? 0.0
                self.isArithmeticOperationButtonTapped = true
                if expressionOfCalculations.last != "-" {
                    self.resultValueDisplayed = "-"
                    self.expressionOfCalculations = "\(self.expressionOfCalculations)-"
                }
            }
            else if button == .mutliply {
                self.currentArithmeticOperation = .multiply
                self.runningNumberValue = Double(self.resultValueDisplayed) ?? 0.0
                self.isArithmeticOperationButtonTapped = true
                if expressionOfCalculations.last != "x" {
                    self.resultValueDisplayed = "x"
                    self.expressionOfCalculations = "\(self.expressionOfCalculations)x"
                }
            }
            else if button == .divide {
                self.currentArithmeticOperation = .divide
                self.runningNumberValue = Double(self.resultValueDisplayed) ?? 0.0
                self.isArithmeticOperationButtonTapped = true
                if expressionOfCalculations.last != "/" {
                    self.resultValueDisplayed = "/"
                    self.expressionOfCalculations = "\(self.expressionOfCalculations)/"
                }
            }
            else if button == .equal {
                let runningValue = self.runningNumberValue
                let currentValue = Double(self.resultValueDisplayed) ?? 0.0
                self.isArithmeticOperationButtonTapped = false
                switch self.currentArithmeticOperation {
                case .add: self.resultValueDisplayed = ridZero(result: (runningValue + currentValue))
                case .subtract: self.resultValueDisplayed = ridZero(result: (runningValue - currentValue))
                case .multiply: self.resultValueDisplayed = ridZero(result: (runningValue * currentValue))
                case .divide: self.resultValueDisplayed = ridZero(result: (runningValue / currentValue))
                case .none:
                    break
                }
                expressionOfCalculations = "\(self.expressionOfCalculations)=\(self.resultValueDisplayed)"
            }
        case .clear:
            self.resultValueDisplayed = "0"
            self.expressionOfCalculations = ""
            self.isArithmeticOperationButtonTapped = false
        case .decimal:
            if self.resultValueDisplayed != "+" && self.resultValueDisplayed != "-" && self.resultValueDisplayed != "/" && self.resultValueDisplayed != "x" {
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
        case .percent:
            if self.resultValueDisplayed != "+" && self.resultValueDisplayed != "-" && self.resultValueDisplayed != "/" && self.resultValueDisplayed != "x" {
                self.resultValueDisplayed = ridZero(result: (Double(self.resultValueDisplayed) ?? 0.0) / 100.0)
                self.expressionOfCalculations = "\(self.expressionOfCalculations)/100 = \(self.resultValueDisplayed)"
            }
            break
        case .negative:
            if self.resultValueDisplayed != "+" && self.resultValueDisplayed != "-" && self.resultValueDisplayed != "/" && self.resultValueDisplayed != "x" {
                let valueBeforeNegative = Double(self.resultValueDisplayed) ?? 0.0
                self.resultValueDisplayed = ridZero(result:valueBeforeNegative * -1)
                self.expressionOfCalculations = "\(self.expressionOfCalculations)x-1 = \(self.resultValueDisplayed)"
            }
        default:
            let number = button.rawValue
            if self.isArithmeticOperationButtonTapped == true {
                if self.resultValueDisplayed != "+" && self.resultValueDisplayed != "-" && self.resultValueDisplayed != "/" && self.resultValueDisplayed != "x" {
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
        print("DidTap \(resultValueDisplayed) \(expressionOfCalculations)")
    }
    
    private func ridZero(result: Double) -> String {
        let value = String(format: "%g", result)
        return value
    }
}

//
//  CalculatorView.swift
//  ArithmeticCalculatorWithSwiftUI
//
//  Created by Gaurav Tak on 06/08/23.
//

import SwiftUI

struct CalculatorView: View {
    @State var valueDisplayed = "0"
    @State var runningNumberValue = 0.0
    @State var currentArithmeticOperation: ArithmeticOperation = .none
    @State var isArithmeticOperationButtonTapped = false
    @State var expressionOfCalculations = ""
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                HStack (alignment: .top) {
                    Spacer()
                    Text(expressionOfCalculations)
                        .font(.system(size: 20))
                        .foregroundColor(.white).lineLimit(4).frame(alignment: .trailing)
                }.frame(maxWidth: .infinity)
                Spacer()
                
                // Text display
                HStack {
                    Spacer()
                    Text(valueDisplayed)
                        .bold()
                        .font(.system(size: 100))
                        .minimumScaleFactor(0.4)
                        .foregroundColor(.white)
                }
                .padding()
                // Our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                //  Button Action Implementation
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(self.buttonBackgroundColor(item: item))
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
}

extension CalculatorView {
    
    func ridZero(result: Double) -> String {
        let value = String(format: "%g", result)
        return value
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonBackgroundColor(item: CalcButton) -> Color {
        switch item {
        case .add, .subtract, .mutliply, .divide, .equal:
            return .blue
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}
extension CalculatorView {
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .mutliply, .divide, .equal:
            if isArithmeticOperationButtonTapped && (button == .add || button == .divide || button == .mutliply || button == .subtract) {
                didTap(button: .equal)
            }
            if button == .add {
                self.currentArithmeticOperation = .add
                self.runningNumberValue = Double(self.valueDisplayed) ?? 0.0
                self.isArithmeticOperationButtonTapped = true
                self.valueDisplayed = "\(self.valueDisplayed)+"
                if expressionOfCalculations.last != "+" {
                    self.valueDisplayed = "+"
                    self.expressionOfCalculations = "\(self.expressionOfCalculations)+"
                }
                
            }
            else if button == .subtract {
                self.currentArithmeticOperation = .subtract
                self.runningNumberValue = Double(self.valueDisplayed) ?? 0.0
                self.isArithmeticOperationButtonTapped = true
                if expressionOfCalculations.last != "-" {
                    self.valueDisplayed = "-"
                    self.expressionOfCalculations = "\(self.expressionOfCalculations)-"
                }
            }
            else if button == .mutliply {
                self.currentArithmeticOperation = .multiply
                self.runningNumberValue = Double(self.valueDisplayed) ?? 0.0
                self.isArithmeticOperationButtonTapped = true
                if expressionOfCalculations.last != "x" {
                    self.valueDisplayed = "x"
                    self.expressionOfCalculations = "\(self.expressionOfCalculations)x"
                }
            }
            else if button == .divide {
                self.currentArithmeticOperation = .divide
                self.runningNumberValue = Double(self.valueDisplayed) ?? 0.0
                self.isArithmeticOperationButtonTapped = true
                if expressionOfCalculations.last != "/" {
                    self.valueDisplayed = "/"
                    self.expressionOfCalculations = "\(self.expressionOfCalculations)/"
                }
            }
            else if button == .equal {
                let runningValue = self.runningNumberValue
                let currentValue = Double(self.valueDisplayed) ?? 0.0
                self.isArithmeticOperationButtonTapped = false
                switch self.currentArithmeticOperation {
                case .add: self.valueDisplayed = ridZero(result: (runningValue + currentValue))
                case .subtract: self.valueDisplayed = ridZero(result: (runningValue - currentValue))
                case .multiply: self.valueDisplayed = ridZero(result: (runningValue * currentValue))
                case .divide: self.valueDisplayed = ridZero(result: (runningValue / currentValue))
                case .none:
                    break
                }
                expressionOfCalculations = "\(self.expressionOfCalculations)=\(self.valueDisplayed)"
            }
        case .clear:
            self.valueDisplayed = "0"
            self.expressionOfCalculations = ""
            self.isArithmeticOperationButtonTapped = false
        case .decimal:
            if self.valueDisplayed != "+" && self.valueDisplayed != "-" && self.valueDisplayed != "/" && self.valueDisplayed != "x" {
                if self.valueDisplayed.contains(".") {
                    // dont do anything
                } else {
                    self.valueDisplayed = "\(self.valueDisplayed)."
                    self.expressionOfCalculations = "\(self.expressionOfCalculations)."
                }
            } else {
                self.valueDisplayed = "."
                self.expressionOfCalculations = "\(self.expressionOfCalculations)."
            }
        case .percent:
            if self.valueDisplayed != "+" && self.valueDisplayed != "-" && self.valueDisplayed != "/" && self.valueDisplayed != "x" {
                self.valueDisplayed = ridZero(result: (Double(self.valueDisplayed) ?? 0.0) / 100.0)
                self.expressionOfCalculations = "\(self.expressionOfCalculations)/100 = \(self.valueDisplayed)"
            }
            break
        case .negative:
            if self.valueDisplayed != "+" && self.valueDisplayed != "-" && self.valueDisplayed != "/" && self.valueDisplayed != "x" {
                let valueBeforeNegative = Double(self.valueDisplayed) ?? 0.0
                self.valueDisplayed = ridZero(result:valueBeforeNegative * -1)
                self.expressionOfCalculations = "\(self.expressionOfCalculations)x-1 = \(self.valueDisplayed)"
            }
        default:
            let number = button.rawValue
            if self.isArithmeticOperationButtonTapped == true {
                if self.valueDisplayed != "+" && self.valueDisplayed != "-" && self.valueDisplayed != "/" && self.valueDisplayed != "x" {
                    self.valueDisplayed = "\(self.valueDisplayed)\(number)"
                } else {
                    self.valueDisplayed = number
                }
            }
            else {
                if self.valueDisplayed != "0" {
                    self.valueDisplayed = "\(self.valueDisplayed)\(number)"
                } else {
                    self.valueDisplayed = number
                }
            }
            self.expressionOfCalculations = "\(self.expressionOfCalculations)\(number)"
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}


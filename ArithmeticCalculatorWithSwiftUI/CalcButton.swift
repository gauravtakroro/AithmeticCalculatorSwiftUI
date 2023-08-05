//
//  CalcButton.swift
//  ArithmeticCalculatorWithSwiftUI
//
//  Created by Gaurav Tak on 06/08/23.
//

import Foundation

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
}

enum ArithmeticOperation {
    case add, subtract, multiply, divide, none
}

//
//  ContentView.swift
//  ArithmeticCalculatorWithSwiftUI
//
//  Created by Gaurav Tak on 05/08/23.
//

import SwiftUI

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

    var buttonBackgroundColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            return .blue
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image("home_icon")
            Text("Calculator").font(.system(size: 72))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

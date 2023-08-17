//
//  CalculatorView.swift
//  ArithmeticCalculatorWithSwiftUI
//
//  Created by Gaurav Tak on 06/08/23.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject var calculatorViewModel = CalculatorViewModel()
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
                    Text(calculatorViewModel.expressionOfCalculations)
                        .font(.system(size: 20))
                        .foregroundColor(.white).lineLimit(4).frame(alignment: .trailing)
                }.frame(maxWidth: .infinity)
                Spacer()
                
                // Text display
                HStack {
                    Spacer()
                    Text(calculatorViewModel.resultValueDisplayed)
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
                                self.calculatorViewModel.didTap(button: item)
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
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .equal  {
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
struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}


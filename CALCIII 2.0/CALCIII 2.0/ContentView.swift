//
//  ContentView.swift
//  CALCIII 2.0
//
//  Created by Student on 25/07/25.
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
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color{
        switch self {
        case .add, .subtract,.multiply, .divide,.equal :
            return .orange
        case .clear, .negative,.percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red:55/255.0, green:55/255.0,blue: 55/255.0, alpha: 1))
        }
    }

    
}
enum Operation {
    case add, subtract ,multiply, divide,none
}

struct ContentView: View {
    @State var value = "0"
    @State var runningNumber = 0
    @State  var currentOperation : Operation = .none
    
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                //  TEXT Display
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundStyle(.white)
                }
                .padding()

                // Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                                // Button tap action here
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
      
    func didTap(button: CalcButton) {
        if button == .add || button == .subtract || button == .multiply || button == .divide {
            if button == .add {
                self.currentOperation = .add
            } else if button == .subtract {
                self.currentOperation = .subtract
            } else if button == .multiply {
                self.currentOperation = .multiply
            } else if button == .divide {
                self.currentOperation = .divide
            }
            self.runningNumber = Int(self.value) ?? 0
            self.value = "0"
        }
        
        else if button == .equal {
            let currentValue = Int(self.value) ?? 0
            
            if self.currentOperation == .add {
                self.value = "\(self.runningNumber + currentValue)"
            } else if self.currentOperation == .subtract {
                self.value = "\(self.runningNumber - currentValue)"
            } else if self.currentOperation == .multiply {
                self.value = "\(self.runningNumber * currentValue)"
            } else if self.currentOperation == .divide {
                if currentValue != 0 {
                    self.value = "\(self.runningNumber / currentValue)"
                } else {
                    self.value = "Error"
                }
            }
            
            self.currentOperation = .none
        }
        
        else if button == .clear {
            self.value = "0"
            self.runningNumber = 0
            self.currentOperation = .none
        }
        
        else if button == .decimal {
            if !self.value.contains(".") {
                self.value += "."
            }
        }
        
        else if button == .negative {
            if self.value.first == "-" {
                self.value.removeFirst()
            } else if self.value != "0" {
                self.value = "-" + self.value
            }
        }
        
        else if button == .percent {
            if let val = Double(self.value) {
                self.value = "\(val / 100)"
            }
        }
        
        else {
            // Number input
            let number = button.rawValue
            if self.value == "0" {
                self.value = number
            } else {
                self.value += number
            }
        }
    }

    
                        
      
    
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2 + 12        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


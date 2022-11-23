//
//  ContentView.swift
//  WeSplit
//
//  Created by Alina Costache on 08.11.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = 0..<101
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalCheck: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    amountIsFocused = false
                                }
                            }
                        }
                        .focused($amountIsFocused)
                } header: {
                    Text("Amount per person")
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }

                Section {
                    Text(totalCheck, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .modifier(CustomTitle(tipPercentage: tipPercentage))
                } header: {
                    Text("Total check amount")
                }
            }
        }
        .navigationTitle("WeSplit")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14")
    }
}

struct CustomTitle: ViewModifier {
    var tipPercentage: Int
    
    func body(content: Content) -> some View {
        if tipPercentage == 0 {
            content
                .foregroundColor(.red)
        } else {
            content.foregroundColor(.black)
        }
    }
}


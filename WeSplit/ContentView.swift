//
//  ContentView.swift
//  WeSplit
//
//  Created by enesozmus on 1.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var _checkAmount = 0.0
    @State private var _numberOfPeople = 2
    @State private var _tipPercentage = 20
    @FocusState private var _amountIsFocused: Bool
    
    let _tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(_numberOfPeople + 2)
        let tipSelection = Double(_tipPercentage)
        
        let tipValue = _checkAmount / 100 * tipSelection
        let grandTotal = _checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var totalAmount: Double {
        let peopleCount = Double(_numberOfPeople + 2)
        let tipSelection = Double(_tipPercentage)
        
        let tipValue = _checkAmount / 100 * tipSelection
        let grandTotal = _checkAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    // TextField("Amount", text: $_checkAmount)
                    // TextField("Amount", value: $checkAmount, format: .currency(code: "USD"))
                    TextField("Amount", value: $_checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($_amountIsFocused)
                    
                    Picker("Number of people", selection: $_numberOfPeople) {
                        ForEach(2..<21) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $_tipPercentage) {
                        ForEach(_tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Grand total") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if _amountIsFocused {
                    Button("Done") {
                        _amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

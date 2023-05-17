//
//  ContentView.swift
//  we-split
//
//  Created by Christopher Sherman on 2023-05-16.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeopleIdx = 0
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double {
        return checkAmount * (1.0 + Double(tipPercentage) / 100) / Double(numberOfPeopleIdx + 2)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Check amount")) {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeopleIdx) {
                        ForEach(2..<100) { val in
                            Text("\(val) people")
                        }
                    }
                }
                
                Section(header: Text("Tip percentage")) {
                    Picker("Tip", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { val in
                            Text(val, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Amount per person")) {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

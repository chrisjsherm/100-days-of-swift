//
//  ContentView.swift
//  unit-conversion
//
//  Created by Christopher Sherman on 2023-05-19.
//

import SwiftUI

struct ContentView: View {
    private var units: Array<BakingUnit>
    @State private var sourceUnitSelection: BakingUnit
    @State private var targetUnitSelection: BakingUnit
    @State private var value: Double?
    @State private var valueMl: Double?
    
    private func convertToMl(value: Double?) -> Double {
        guard let value else {
            return 0
        }
        
        switch sourceUnitSelection {
        case .Cup:
            return value * 237
        case .Ounce:
            return value * (237 / 8)
        case .Tablespoon:
            return value * (237 / 16)
        case .Teaspoon:
            return value * (237 / 48)
        case .Milliliter:
            return value
        }
    }
    
    var equivalentValueInTargetUnits: Double {
        guard let valueMl else {
            return 0
        }
        
        switch targetUnitSelection {
        case .Cup:
            return valueMl / 237.0 * 1.0
        case .Ounce:
            return valueMl / 237.0 * 8.0
        case .Tablespoon:
            return valueMl / 237.0 * 16.0
        case .Teaspoon:
            return valueMl / 237.0 * 48
        case .Milliliter:
            return valueMl
        }
    }
    
    init() {
        units = []
        for unit in BakingUnit.allCases {
            units.append(unit)
        }
        sourceUnitSelection = BakingUnit.Teaspoon
        targetUnitSelection = BakingUnit.Tablespoon
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Source")) {
                    LabeledContent {
                        TextField("Enter a value", value: $value, format: .number)
                            .keyboardType(.decimalPad)
                            .onChange(of: value) { newValue in
                                valueMl = convertToMl(value: newValue)
                            }
                    } label: {
                        Text("Amount")
                    }
                    
                    Picker("Units", selection: $sourceUnitSelection) {
                        ForEach(units, id: \.self) { val in
                            Text(val.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: sourceUnitSelection) {_ in
                        valueMl = convertToMl(value: value)
                    }
                }
                
                Section(header: Text("Target")) {
                    Picker("Units", selection: $targetUnitSelection) {
                        ForEach(units, id: \.self) { val in
                            Text(val.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: targetUnitSelection) { _ in
                        valueMl = convertToMl(value: value)
                    }
                }
                
                Section(header: Text("Result")) {
                    Text("\(equivalentValueInTargetUnits, specifier: "%.2f") \(targetUnitSelection.rawValue)")
                }
            }.navigationTitle("Baking units converter")
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  AddView.swift
//  iExpense
//
//  Created by Christopher Sherman on 2023-06-20.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type: ExpenseType = .Business
    @State private var amount = 0.0
    
    @ObservedObject var expenses: Expenses
    
    @Environment(\.dismiss) var dismiss
        
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases) { option in
                        Text(String(describing: option))
                    }
                }
                
                TextField("Amount", value: $amount, format: AppConstants.currencyFormat)
                    .keyboardType(.decimalPad)
            }.navigationTitle("Add new expense")
                .toolbar {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

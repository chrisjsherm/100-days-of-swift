//
//  ContentView.swift
//  iExpense
//
//  Created by Christopher Sherman on 2023-06-19.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.name) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }.navigationTitle("iExpense")
                .toolbar {
                    Button {
                        let expense = ExpenseItem(name: "Text", type: "Personal", amount: 5)
                        expenses.items.append(expense)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

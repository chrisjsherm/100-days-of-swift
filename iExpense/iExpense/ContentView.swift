//
//  ContentView.swift
//  iExpense
//
//  Created by Christopher Sherman on 2023-06-19.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(expenses.items.filter({ $0.type == ExpenseType.Personal })) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(String(describing: item.type))
                            }
                            
                            Spacer()
                            Text(item.amount, format: AppConstants.currencyFormat)
                                .heatified(amount: item.amount)
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                } header: {
                    Text("Personal expenses")
                }
                
                Section {
                    ForEach(expenses.items.filter({ $0.type == ExpenseType.Business })) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(String(describing: item.type))
                            }
                            
                            Spacer()
                            Text(item.amount, format: AppConstants.currencyFormat)
                                .heatified(amount: item.amount)
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                } header: {
                    Text("Business expenses")
                }
                
            }.navigationTitle("iExpense")
                .toolbar {
                    Button {
                        showingAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    private func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, expenseType: ExpenseType.Personal)
    }
    
    private func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, expenseType: ExpenseType.Business)

    }
    
    private func removeItems(at offsets: IndexSet, expenseType: ExpenseType) {
        let filteredItems = expenses.items.filter({ $0.type == expenseType })
        let expensesToRemove = offsets.map({ filteredItems[$0].id })
        expenses.items.removeAll(where: { expensesToRemove.contains($0.id) })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

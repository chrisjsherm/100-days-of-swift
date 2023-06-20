//
//  Expenses.swift
//  iExpense
//
//  Created by Christopher Sherman on 2023-06-20.
//

import Foundation

class Expenses: ObservableObject {
    let ITEMS_KEY = "Items"
    
    @Published var items = Array<ExpenseItem>() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: ITEMS_KEY)
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: ITEMS_KEY) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

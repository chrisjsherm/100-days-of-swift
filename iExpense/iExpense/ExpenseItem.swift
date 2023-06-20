//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Christopher Sherman on 2023-06-20.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

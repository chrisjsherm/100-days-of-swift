//
//  Expenses.swift
//  iExpense
//
//  Created by Christopher Sherman on 2023-06-20.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = Array<ExpenseItem>()
}

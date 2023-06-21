//
//  ExpenseType.swift
//  iExpense
//
//  Created by Christopher Sherman on 2023-06-21.
//

import Foundation

enum ExpenseType: CaseIterable, Identifiable, CustomStringConvertible, Codable {
    case Personal
    case Business
    
    var id: Self {
        return self
    }
    
    var description: String {
        switch self {
        case .Business:
            return "Business"
            
        case .Personal:
            return "Personal"
        }
    }
}

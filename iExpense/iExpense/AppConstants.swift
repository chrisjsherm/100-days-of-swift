//
//  AppConstants.swift
//  iExpense
//
//  Created by Christopher Sherman on 2023-06-21.
//

import Foundation

enum AppConstants {
    static let currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "EUR")
}

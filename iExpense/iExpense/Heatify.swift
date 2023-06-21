//
//  Heatify.swift
//  iExpense
//
//  Created by Christopher Sherman on 2023-06-21.
//

import SwiftUI

struct Heatify: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
    }
}

extension View {
    func heatified(amount: Double) -> some View {
        if (amount < 10.0) {
            return modifier(Heatify(color: .black))
        } else if (amount < 100.0) {
            return modifier(Heatify(color: .orange))
        }
        
        return modifier(Heatify(color: .red))
    }
}

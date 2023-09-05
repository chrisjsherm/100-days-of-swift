//
//  Extension-StackedView.swift
//  Flashzilla
//
//  Created by Christopher Sherman on 2023-09-05.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

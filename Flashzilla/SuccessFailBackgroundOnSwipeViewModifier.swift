//
//  SuccessFailBackgroundOnSwipeViewModifier.swift
//  Flashzilla
//
//  Created by Christopher Sherman on 2023-09-08.
//

import SwiftUI


extension Shape {
    func successFailBackground(offset: CGSize, defaultColor: Color) -> some View {
        if offset.width > 0 {
            return self
                .fill(.green)
        }
        
        if offset.width < 0 {
            return self
                .fill(.red)
        }
        
        return self.fill(defaultColor)
    }
}


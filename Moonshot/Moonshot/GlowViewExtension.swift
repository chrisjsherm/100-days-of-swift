//
//  GlowViewExtension.swift
//  Moonshot
//
//  Created by Christopher Sherman on 2023-06-26.
//

import SwiftUI

extension View {
    func glow(color: Color = .white, radius: CGFloat = 20) -> some View {
        self
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)        
    }
}

//
//  ImBlue.swift
//  Views and Modifiers
//
//  Created by Christopher Sherman on 2023-05-26.
//

import SwiftUI

struct ImBlue: ViewModifier {
   
    func body(content: Content) -> some View {
            content
                .font(.largeTitle)
                .foregroundColor(.blue)
    }
}



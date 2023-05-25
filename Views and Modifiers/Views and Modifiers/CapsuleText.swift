//
//  CapsuleText.swift
//  Views and Modifiers
//
//  Created by Christopher Sherman on 2023-05-25.
//

import SwiftUI

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}

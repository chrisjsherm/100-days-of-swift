//
//  ContentView.swift
//  Animations
//
//  Created by Christopher Sherman on 2023-06-08.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        return VStack {
            Button("Tap Me") {
                withAnimation(.interpolatingSpring(stiffness: 10, damping: 5)) {
                    animationAmount += 360
                }
            }
            .padding(40)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 1))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

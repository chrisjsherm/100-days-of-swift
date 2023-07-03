//
//  ContentView.swift
//  Drawing
//
//  Created by Christopher Sherman on 2023-06-28.
//

import SwiftUI

struct ContentView: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            Text("Color-cycling Rectangle")
            
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle, in: 0.0...1.0)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

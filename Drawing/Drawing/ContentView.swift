//
//  ContentView.swift
//  Drawing
//
//  Created by Christopher Sherman on 2023-06-28.
//

import SwiftUI

struct ContentView: View {
    @State private var strokeWidth = 5.0

    var body: some View {
        VStack {
            Text("Arrow")
            
            Arrow()
                .stroke(.blue, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 200, height: 200)
            
            Slider(value: $strokeWidth, in: 1.0...25.0)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

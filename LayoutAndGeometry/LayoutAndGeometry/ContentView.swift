//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Christopher Sherman on 2023-09-11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Text("Hello, World!")
                    .frame(width: geo.size.width * 0.9, height: 40)
                    .background(.red)
            }
            .background(.green)
    
            Text("More text")
                .background(.blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  Drawing
//
//  Created by Christopher Sherman on 2023-06-28.
//

import SwiftUI

struct ContentView: View {
    @State private var petalOffset = -14.0
    @State private var petalWidth = 51.0
    
    var body: some View {
        VStack {
            Text("Hello World")
                .frame(width: 300, height: 300)
                .border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.3), width: 30)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  Drawing
//
//  Created by Christopher Sherman on 2023-06-28.
//

import SwiftUI

struct ContentView: View {
    @State private var insetAmount = 50.0

    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation {
                    insetAmount = Double.random(in: 10...90)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

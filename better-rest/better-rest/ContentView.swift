//
//  ContentView.swift
//  better-rest
//
//  Created by Christopher Sherman on 2023-05-31.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount: Double
    
    init() {
        sleepAmount = 8.0
    }
    
    var body: some View {
        VStack {
            VStack {
                Stepper("\(sleepAmount.formatted()) \(sleepAmount.formatted() == "1" ? "hour" : "hours")", value: $sleepAmount, in: 0...24, step: 0.25)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

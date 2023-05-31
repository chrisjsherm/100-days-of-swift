//
//  ContentView.swift
//  better-rest
//
//  Created by Christopher Sherman on 2023-05-31.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeDate = Date.now
        
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    DatePicker("Please enter a date", selection: $wakeDate)
                    
                    Stepper("\(sleepAmount.formatted()) \(sleepAmount.formatted() == "1" ? "hour" : "hours")", value: $sleepAmount, in: 0...24, step: 0.25)
                }
            }
            .padding()
        }
        .navigationTitle("Better Rest")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

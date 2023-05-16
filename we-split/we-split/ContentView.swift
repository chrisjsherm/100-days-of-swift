//
//  ContentView.swift
//  we-split
//
//  Created by Christopher Sherman on 2023-05-16.
//

import SwiftUI

struct ContentView: View {
    @State var tapCount = 0

    var body: some View {
        Button("Tap Count: \(tapCount)") {
            self.tapCount += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

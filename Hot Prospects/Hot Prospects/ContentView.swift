//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Christopher Sherman on 2023-08-23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  Views and Modifiers
//
//  Created by Christopher Sherman on 2023-05-25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CapsuleText(text: "Hello")
            CapsuleText(text: "World")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

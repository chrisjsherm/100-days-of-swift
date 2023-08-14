//
//  ContentView.swift
//  Voice Over
//
//  Created by Christopher Sherman on 2023-08-14.
//

import SwiftUI

struct ContentView: View {
  @State private var selectedPicture = Int.random(in: 0...3)

    var body: some View {
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Your score is 1000")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

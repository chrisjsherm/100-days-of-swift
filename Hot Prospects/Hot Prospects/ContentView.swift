//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Christopher Sherman on 2023-08-23.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor = Color.red

        var body: some View {
            VStack {
                Text("Hello, World!")
                    .padding()
                    .background(backgroundColor)

                Text("Change Color")
                    .padding()
                    .contextMenu {
                        Button("Red") {
                            backgroundColor = .red
                        }

                        Button("Green") {
                            backgroundColor = .green
                        }

                        Button("Blue") {
                            backgroundColor = .blue
                        }
                    }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

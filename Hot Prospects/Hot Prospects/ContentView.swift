//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Christopher Sherman on 2023-08-23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var user = User()
    @State private var selectedTab = "One"
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                EditView()
                    .tabItem {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tag("One")

                DisplayView()
                    .tabItem {
                        Label("Display", systemImage: "note")
                    }
                    .tag("Two")
            }
        }
        .environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

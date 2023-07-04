//
//  ContentView.swift
//  Habits
//
//  Created by Christopher Sherman on 2023-07-04.
//

import SwiftUI

struct ContentView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Sport.allCases) { item in
                        NavigationLink("\(item.rawValue)") {
                            DetailView(sport: item)
                        }
                    }
                }
            }
            .navigationTitle("Habits")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

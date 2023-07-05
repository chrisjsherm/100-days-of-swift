//
//  ContentView.swift
//  Habits
//
//  Created by Christopher Sherman on 2023-07-04.
//

import SwiftUI

struct ContentView: View {
    @State var customActivities: Array<Activity> = []
    
    @State private var showingCustomForm = false
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Sports").font(.title2)
                    
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 15) {
                        ForEach(Sport.allCases) { item in
                            NavigationLink("\(item.rawValue)") {
                                DetailView(name: item.rawValue)
                            }
                        }
                    }
                    
                    Divider()
                        .padding([.top, .bottom])
                    
                    Text("Custom")
                        .font(.title2)
                        .padding(.bottom, 5)
                    
                    Button("New Custom Activity") {
                        showingCustomForm.toggle()
                    }
                    .sheet(isPresented: $showingCustomForm) {
                        CustomActivityFormView( customActivities: $customActivities)
                    }
                    
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 15) {
                        ForEach(customActivities) { item in
                            NavigationLink("\(item.name)") {
                                DetailView(name: item.name)
                            }
                        }
                    }
                    .padding(.top)
                }
                .padding([.leading, .trailing])
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

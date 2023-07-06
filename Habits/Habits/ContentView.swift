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
    private let defaults = UserDefaults.standard
    static let keyCustomActivities = "CustomActivities"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Sports").font(.title2)
                    
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 15) {
                        ForEach(Sport.allCases) { item in
                            let key = "\(item.rawValue):hours"
                            // Defaults to 0 when the key does not exist.
                            let hours = defaults.integer(forKey: key)                            
                            let activity = Activity(name: "\(item.rawValue)", description: "", hoursCompleted: hours)
                            
                            NavigationLink("\(item.rawValue)") {
                                DetailView(activity: activity)
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
                        CustomActivityFormView(customActivities: $customActivities)
                    }
                    
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 15) {
                        ForEach(customActivities) { item in
                            NavigationLink("\(item.name)") {
                                DetailView(activity: item)
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

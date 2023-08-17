//
//  ContentView.swift
//  Rolodex
//
//  Created by Christopher Sherman on 2023-08-17.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddContact = false
    
    var body: some View {
        NavigationView {
            List {
                
            }
            .navigationTitle("Rolodex")
                .toolbar {
                    Button {
                        showAddContact = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
        }
        .sheet(isPresented: $showAddContact) {
            AddContactView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

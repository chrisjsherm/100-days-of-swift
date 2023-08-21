//
//  ContentView.swift
//  Rolodex
//
//  Created by Christopher Sherman on 2023-08-17.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddContact = false
    
    @FetchRequest(sortDescriptors: []) var contacts: FetchedResults<Person>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contacts) { contact in
                    NavigationLink {
                        DetailView(contact: contact)
                    } label: {
                        HStack {                               
                            Image(uiImage: contact.contactPhoto)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                            
                            Text(contact.name ?? "Unknown contact") 
                        }
                    }
                }
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

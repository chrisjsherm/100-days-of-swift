//
//  ContentView.swift
//  Snow Seeker
//
//  Created by Christopher Sherman on 2023-09-15.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedUser: User? = nil

    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                selectedUser = User()
            }
            .sheet(item: $selectedUser) { user in
                Text(user.id)
            }
    }
}

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

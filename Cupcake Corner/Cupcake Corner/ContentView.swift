//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Christopher Sherman on 2023-07-07.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    
    var isInvalid: Bool {
        username.count < 5 || email.count < 5
    }

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
            .disabled(isInvalid)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

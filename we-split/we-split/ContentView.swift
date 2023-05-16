//
//  ContentView.swift
//  we-split
//
//  Created by Christopher Sherman on 2023-05-16.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"

    var body: some View {
        NavigationView {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
            }
        }
    }
}

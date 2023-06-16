//
//  ContentView.swift
//  Multiply
//
//  Created by Christopher Sherman on 2023-06-15.
//

import SwiftUI

struct ContentView: View {
    @State private var level = 2.0
    @State private var questionCount = QuestionCount.Five

    var body: some View {
        NavigationStack {
            SettingsView(level: $level, questionCount: $questionCount)
                .navigationTitle("Settings")
                .toolbar {
                    NavigationLink("Play") {
                        GameView(level: Int(level), questionCount: questionCount.rawValue)
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

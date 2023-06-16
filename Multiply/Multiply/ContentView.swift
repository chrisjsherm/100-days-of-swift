//
//  ContentView.swift
//  Multiply
//
//  Created by Christopher Sherman on 2023-06-15.
//

import SwiftUI
import Combine

struct SettingsView: View {
    @Binding var level: Double
    @State var questionCount: QuestionCount
    
    var body: some View {
        List {
            Section(header: Text("Level")) {
                Stepper("\(level, specifier: "%.0f")", value: $level, in: 2...12, step: 1.0)
            }
            
            Section(header: Text("Question count")) {
                Picker(selection: $questionCount, label: Text("Question count")) {
                    Text("\(QuestionCount.Five.rawValue)").tag(QuestionCount.Five)
                    Text("\(QuestionCount.Ten.rawValue)").tag(QuestionCount.Ten)
                    Text("\(QuestionCount.Twenty.rawValue)").tag(QuestionCount.Twenty)
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
        }
    }
}

struct ContentView: View {
    @State private var level = 2.0

    var body: some View {
        NavigationStack {
            SettingsView(level: $level, questionCount: QuestionCount.Five)
                .navigationTitle("Settings")
                .toolbar {
                    NavigationLink("Start") {
                        GameView(level: Int(level))
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

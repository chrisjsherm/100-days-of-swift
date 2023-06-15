//
//  ContentView.swift
//  Multiply
//
//  Created by Christopher Sherman on 2023-06-15.
//

import SwiftUI

enum QuestionCount: Int {
    case Five = 5
    case Ten = 10
    case Twenty = 20
}

struct SettingsView: View {
    @State var level: Double
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
    var body: some View {
        SettingsView(level: 2.0, questionCount: QuestionCount.Five)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

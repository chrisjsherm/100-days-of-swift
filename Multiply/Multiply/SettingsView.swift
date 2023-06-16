//
//  SettingsView.swift
//  Multiply
//
//  Created by Christopher Sherman on 2023-06-16.
//

import SwiftUI

struct SettingsView: View {
    @Binding var level: Double
    @Binding var questionCount: QuestionCount
    
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

struct SettingsView_Previews: PreviewProvider {
    @State static var level = 2.0
    @State static var questionCount = QuestionCount.Five
    
    static var previews: some View {
        SettingsView(level: $level, questionCount: $questionCount)
    }
}

//
//  ContentView.swift
//  Multiply
//
//  Created by Christopher Sherman on 2023-06-15.
//

import SwiftUI
import Combine

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

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

struct GameView: View {
    @State private var answer: Int?
    @State private var errorMessage = ""
    @State private var first: Int?
    @State private var isAnswerValid: Bool?
    @State private var isShowingError = true
    @State private var resultMessage = ""
    @State private var second: Int?
    
    init(level: Int) {
        self.level = level

    }
    
    let level: Int
    
    func askQuestion(level: Int) {
        let first = Int.random(in: 0...level)
        let second = Int.random(in: 2...level)
        
        self.first = first
        self.second = second
    }
    
    func validateAnswer() throws -> Bool {
        guard first != nil && second != nil else {
            fatalError("Multiplication operands were not set.")
        }
        
        guard answer != nil else {
            throw "Answer is not set."
        }
        
        print("Validating \(answer) == \(first) * \(second)")
        
        let result = answer == first! * second!
        if (result) {
            resultMessage = "Correct!"
        } else {
            resultMessage = "That's incorrect."
        }
        return result
    }
    
    var body: some View {
        VStack {
            Text("\(first ?? 1) x \(second ?? 1)")
                .font(.largeTitle)
            
            LabeledContent {
                TextField("Answer", value: $answer, format: .number)
            } label: {
                Text("Answer")
            }
            .padding()
            
            if isShowingError {
                Text("\(errorMessage)")
                    .font(.caption)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            
            if isAnswerValid != nil {
                Text("\(resultMessage)")
                    .font(.callout)
            }
            
            Button("Submit") {
                errorMessage = ""
                do {
                    isAnswerValid = try validateAnswer()
                } catch {
                    errorMessage = "Please enter an answer"
                }
            }
        }
        .onAppear() {
            askQuestion(level: level)
        }
    }
}

struct ContentView: View {
    var body: some View {
//        NavigationStack {
//            SettingsView(level: 2.0, questionCount: QuestionCount.Five)
//                .navigationTitle("Settings")
//                .toolbar {
//                    NavigationLink("Start") {
//                        GameView()
//                    }
//                }
//        }
        GameView(level: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

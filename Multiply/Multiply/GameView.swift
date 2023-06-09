//
//  GameView.swift
//  Multiply
//
//  Created by Christopher Sherman on 2023-06-16.
//

import SwiftUI

struct GameView: View {
    @State private var answer: Int?
    @State private var errorMessage = ""
    @State private var isAnswerValid: Bool?
    @State private var operandFirst: Int?
    @State private var operandSecond: Int?
    @State private var questionCount: Int
    @State private var questionNumber = 0
    @State private var resultMessage = ""
    
    init(level: Int, questionCount: Int) {
        self.level = level
        self.questionCount = questionCount
    }
    
    let level: Int
    
    var body: some View {
        VStack {
            Text("Level \(level)")
                .font(.callout)
            Text("Question \(questionNumber) of \(questionCount)")
                .font(.caption)
            
            Spacer()
            
            Text("Determine the product of")
                .font(.title2)
                .padding()
            Text("\(operandFirst ?? 1) x \(operandSecond ?? 1)")
                .font(.largeTitle)
            
            LabeledContent {
                TextField("Answer", value: $answer, format: .number)
                    .onSubmit {
                        onSubmit()
                    }
            } label: {
                Text("Product:")
            }
            .padding(.leading)
            .font(.title2)
            
            Text("\(errorMessage)")
                .font(.caption)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Spacer()

            ScrollView {
                if isAnswerValid != nil {
                    Text("\(resultMessage)")
                        .font(.title2)
                        .padding()
                }
            }
                        
            if (resultMessage == "") {
                Button("Submit") {
                    onSubmit()
                }
            } else if (questionNumber < questionCount) {
                Button("Next question") {
                    askQuestion(level: level)
                }
            } else {
                Button("New game") {
                    reset()
                }
            }
        }
        .onAppear() {
            answer = nil
            askQuestion(level: level)
        }
    }
    
    private func askQuestion(level: Int) {
        questionNumber += 1
        resultMessage = ""
        
        let first = Int.random(in: 0...level)
        let second = Int.random(in: 2...level)
        
        self.operandFirst = first
        self.operandSecond = second
    }
    
    private func onSubmit() {
        errorMessage = ""
        do {
            isAnswerValid = try validateAnswer()
        } catch {
            errorMessage = "Please enter an answer"
        }
    }
    
    private func reset() {
        questionNumber = 0
        askQuestion(level: level)
    }
    
    private func validateAnswer() throws -> Bool {
        guard operandFirst != nil && operandSecond != nil else {
            fatalError("Operands were not set.")
        }
        
        guard answer != nil else {
            throw "Answer is not set."
        }
                
        let result = answer == operandFirst! * operandSecond!
        if (result) {
            resultMessage = "Correct!"
        } else {
            resultMessage = "That's incorrect. The correct answer is \(operandFirst! * operandSecond!)."
        }
        return result
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(level: 5, questionCount: 5)
    }
}

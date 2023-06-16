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
    @State private var isShowingError = false
    @State private var operandFirst: Int?
    @State private var operandSecond: Int?
    @State private var resultMessage = ""
    
    init(level: Int) {
        self.level = level
    }
    
    let level: Int
    
    func askQuestion(level: Int) {
        let first = Int.random(in: 0...level)
        let second = Int.random(in: 2...level)
        
        self.operandFirst = first
        self.operandSecond = second
    }
    
    func validateAnswer() throws -> Bool {
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
    
    var body: some View {
        VStack {
            Text("Level \(level)")
                .font(.callout)
            
            Spacer()
            
            Text("Determine the product of")
                .font(.title2)
                .padding()
            Text("\(operandFirst ?? 1) x \(operandSecond ?? 1)")
                .font(.largeTitle)
            
            LabeledContent {
                TextField("Answer", value: $answer, format: .number)
            } label: {
                Text("Product:")
            }
            .padding()
            .font(.title2)
            
            if isShowingError {
                Text("\(errorMessage)")
                    .font(.caption)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
                        
            if isAnswerValid != nil {
                Text("\(resultMessage)")
                    .font(.title)
                    .padding()
            }
            
            Spacer()
            
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(level: 5)
    }
}

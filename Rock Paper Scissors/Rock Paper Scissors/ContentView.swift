//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Christopher Sherman on 2023-05-30.
//

import SwiftUI

struct ContentView: View {
    @State private var computerSelection: TurnChoice?
    @State private var userSelection: TurnChoice
    @State private var currentState: TurnState
    @State private var score: Int
    @State private var turnWinner: TurnWinner?
    @State private var turnCount: Int
    
    private let turnsPerGame = 2
    
    private var turnChoices: Array<TurnChoice>
    
    init() {
        turnCount = 0
        score = 0
        currentState = TurnState.Playing
        
        turnChoices = []
        for choice in TurnChoice.allCases {
            turnChoices.append(choice)
        }
        
        userSelection = TurnChoice.Rock
    }
    
    private func determineWinner() -> TurnWinner {
        if computerSelection == userSelection {
            return TurnWinner.Tie
        }
        
        if computerSelection == TurnChoice.Rock && userSelection == TurnChoice.Paper {
            return TurnWinner.User
        }
        
        if computerSelection == TurnChoice.Paper && userSelection == TurnChoice.Scissors {
            return TurnWinner.User
        }
        
        if computerSelection == TurnChoice.Scissors && userSelection == TurnChoice.Rock {
            return TurnWinner.User
        }
        
        return TurnWinner.Computer
    }
    
    private func onClick() {
        switch currentState {
        case .Playing:
            scoreTurn()
            currentState = turnCount < turnsPerGame ? TurnState.Scoring : TurnState.GameOver
        case .Scoring:
            currentState = TurnState.Playing
        case .GameOver:
            turnCount = 0
            score = 0
            currentState = TurnState.Playing
        }
    }
    
    private func scoreTurn() {
        turnCount += 1
        computerSelection = turnChoices.randomElement()
        let winner = determineWinner()
        turnWinner = winner
        
        if winner == TurnWinner.User {
            score += 1
        } else if winner == TurnWinner.Computer {
            score -= 1
        }
        currentState = TurnState.Scoring
    }
    
    var body: some View {
        VStack {
            Text("Rock Paper Scissors")
                .font(.largeTitle)
            
            Form {
                Picker(selection: $userSelection, label: Text("Select one")) {
                    ForEach(turnChoices, id: \.self) {val in
                        Text(val.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .disabled(currentState != TurnState.Playing)
            }
            .pickerStyle(.menu)
            
            if currentState != TurnState.Playing {
                Text("Computer chose \(computerSelection?.rawValue ?? "nothing").")
                
                Spacer()
                if turnWinner == TurnWinner.Tie {
                    Text("It's a tie.")
                } else if turnWinner == TurnWinner.User {
                    Text("You win!")
                } else {
                    Text("You lost that round :(")
                }
                
                Spacer()
                
                let turnsLeft = turnsPerGame - turnCount
                Text("You have \(score) points. You have \(turnsLeft) \(turnsLeft == 1 ? "turn" : "turns") left.")
            }
                    
            Button {
                onClick()
            } label: {
                switch currentState {
                case .Playing:
                    Text("Go!")
                case .Scoring:
                    Text("Next turn")
                case .GameOver:
                    Text("New game")
                }
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.automatic)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

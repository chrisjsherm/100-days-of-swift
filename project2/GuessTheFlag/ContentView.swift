//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Paul Hudson on 20/10/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var questionNum = 0
    @State private var selectedCountryIndices = Array<Int>()
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var rotationDict: Dictionary<Int, Double> = [:]

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(selectedCountryIndices, id: \.self) { idx in
                        Button {
                            flagTapped(idx)
                        } label: {
                            FlagView(country: countries[idx])
                                .rotation3DEffect(.degrees(rotationDict[idx] ?? 0.0), axis: (x: 0, y: 1, z: 0))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if (questionNum == 8) {
                Button("New game", action: reset)
            } else {
                Button("Continue", action: askQuestion)
            }
        } message: {
            if (questionNum == 8) {
                Text("Your final score is \(score)")
            } else {
                Text("Your score is \(score)")
            }
        }
        .onAppear {
            reset()
        }
    }

    func flagTapped(_ number: Int) {
        withAnimation {
            rotationDict[number] = (rotationDict[number] ?? 0) + 360.0
        }
        
        questionNum += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong—that is the flag of \(countries[number])"
        }
        
        showingScore = true
    }

    func askQuestion() {
        var nextCountryIndices = Set<Int>()
        while (nextCountryIndices.count < 3) {
            nextCountryIndices.insert(Int.random(in: 0..<countries.count))
        }
        
        withAnimation(.linear) {
            selectedCountryIndices = Array(nextCountryIndices)
        }
        correctAnswer = selectedCountryIndices.randomElement() ?? 0
    }
    
    func reset() {
        questionNum = 0
        score = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

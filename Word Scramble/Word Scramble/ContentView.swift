//
//  ContentView.swift
//  Word Scramble
//
//  Created by Christopher Sherman on 2023-06-06.
//

import SwiftUI

struct ContentView: View {
    @State private var presentWords: Array<String> = []
    @State private var usedWords: Set<String> = []
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var freq = [Character: Int]()
    @State private var score = 0

    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {return}
        
        guard isOriginal(word: answer) else {
            onWordError(title: "Word used already", message: "Be more original.")
            return
        }

        guard isPossible(word: answer) else {
            onWordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            onWordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard answer.count >= 3 else {
            onWordError(title: "Word too short", message: "Valid answers must be at least three characters in length.")
            return
        }
        
        guard answer != rootWord else {
            onWordError(title: "Invalid entry", message: "You cannot use the root word.")
            return
        }
        
        score += answer.count
        withAnimation {
            usedWords.insert(answer)
            presentWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempFreq = freq
        
        for char in word {
            let charFreq = tempFreq[char] ?? 0
            
            if charFreq == 0 {
                return false
            }
            
            tempFreq[char] = charFreq - 1
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func onWordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func getRootWord() -> String {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                
                let randomWord = allWords.randomElement() ?? "silkworm"
                
                return randomWord
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func startNewGame() {
        presentWords = [String]()
        usedWords = Set<String>()
        score = 0
        rootWord = getRootWord()

        var frequencyMap = [Character: Int]()
        for char in rootWord {
            let charFreq = frequencyMap[char] ?? 0
            frequencyMap[char] = charFreq + 1
        }
        
        freq = frequencyMap
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
                
                Section {
                    ForEach(presentWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .onAppear(perform: startNewGame)
            .navigationTitle(rootWord)
            .toolbar {
                ToolbarItem {
                    Button("New Game") {
                        startNewGame()
                    }
                }
            }
            .onSubmit(addNewWord)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
        
        Text("Score: \(score)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

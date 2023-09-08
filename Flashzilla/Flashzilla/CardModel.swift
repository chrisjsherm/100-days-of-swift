//
//  CardModel.swift
//  Flashzilla
//
//  Created by Christopher Sherman on 2023-09-05.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")

}

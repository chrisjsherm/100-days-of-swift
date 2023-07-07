//
//  ItunesResponse.swift
//  Cupcake Corner
//
//  Created by Christopher Sherman on 2023-07-07.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

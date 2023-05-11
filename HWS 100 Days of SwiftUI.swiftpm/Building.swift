//
//  Building.swift
//  HWS 100 Days of SwiftUI
//
//  Created by Christopher Sherman on 2023-05-11.
//

import Foundation

protocol Building {
    var rooms: Int {get}
    var cost: Int {get set}
    var agentName: String {get set}
    
    func printSalesSummary() -> String
}

extension Building {
    func printSalesSummary() -> String {
        return """
               This building has \(rooms) rooms and
               costs $\(cost). To schedule a visit, contact
               \(agentName).
               """
    }
}

struct House: Building {
    var rooms: Int
    
    var cost: Int
    
    var agentName: String
}

struct Office: Building {
    var rooms: Int
    
    var cost: Int
    
    var agentName: String
    
    func printSalesSummary() -> String {
        return """
               This office has \(rooms) rooms and
               costs $\(cost). To tour, contact
               \(agentName).
               """
    }
}

//
//  Activity.swift
//  Habits
//
//  Created by Christopher Sherman on 2023-07-04.
//

import Foundation

struct Activity: Identifiable, Codable {
    var id = UUID()
    let name: String
    var description = ""
    var hoursCompleted = 0
    
    init(name: String, description: String = "") {
        self.name = name
        self.description = description
    }
}

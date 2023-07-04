//
//  Activity.swift
//  Habits
//
//  Created by Christopher Sherman on 2023-07-04.
//

import Foundation

class Activity: ObservableObject {
    var name: String
    @Published var isComplete = false
    
    init(name: String, isComplete: Bool = false) {
        self.name = name
        self.isComplete = isComplete
    }
}

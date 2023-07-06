//
//  Activity.swift
//  Habits
//
//  Created by Christopher Sherman on 2023-07-04.
//

import Foundation

class Activity: Identifiable, ObservableObject {
    var id: UUID
    var name: String
    var description: String
    @Published var hoursCompleted: Int
    
    init(name: String, description: String = "", hoursCompleted: Int = 0) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.hoursCompleted = hoursCompleted
    }
}

enum CodingKeys: CodingKey {
    case id, name, description, hoursCompleted
}

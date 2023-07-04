//
//  SportsEnum.swift
//  Habits
//
//  Created by Christopher Sherman on 2023-07-04.
//

import Foundation

enum Sport: String, CaseIterable, Identifiable {
    var id: String {
        return self.rawValue
    }
    
    case baseball = "Baseball"
    case basketball = "Basketball"
    case crosscountry = "Cross Country"
    case football = "Football"
    case lacrosse = "Lacrosse"
    case soccer = "Soccer"
    case softball = "Softball"
    case track = "Track"
    case volleyball = "Volleyball"
}

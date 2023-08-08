//
//  Location.swift
//  Bucket List
//
//  Created by Christopher Sherman on 2023-08-07.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    let longitude: Double
    let latitude: Double
}

//
//  Location.swift
//  Bucket List
//
//  Created by Christopher Sherman on 2023-08-07.
//

import Foundation
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

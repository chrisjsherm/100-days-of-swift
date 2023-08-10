//
//  ContentView-ViewModel.swift
//  Bucket List
//
//  Created by Christopher Sherman on 2023-08-10.
//

import Foundation
import MapKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations = [Location]()
        @Published var selectedPlace: Location?
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New location", description: "", longitude: mapRegion.center.longitude, latitude: mapRegion.center.latitude)
            locations.append(newLocation)
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
        }
    }
}

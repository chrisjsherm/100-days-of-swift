//
//  FavoritesModel.swift
//  Snow Seeker
//
//  Created by Christopher Sherman on 2023-09-20.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    private let DATA_FILE_NAME = "Favorites"
    private var fileURL: URL {
        let fileURL = FileManager.documentsDirectory.appendingPathComponent(
            DATA_FILE_NAME
        )
        
        return fileURL
    }

    init() {
        resorts = []

        if let data = try? Data(contentsOf: fileURL) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = decoded
                return
            }
        }
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(resorts) {
            do {
                try encoded.write(to: fileURL)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

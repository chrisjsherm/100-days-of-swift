//
//  ProspectModel.swift
//  Hot Prospects
//
//  Created by Christopher Sherman on 2023-08-28.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect] = []
    
    private let DATA_FILE_NAME = "SavedData"
    private var fileURL: URL {
        let fileURL = FileManager.documentsDirectory.appendingPathComponent(
            "DATA_FILE_NAME"
        )
        return fileURL
    }

    init() {
        if let data = try? Data(contentsOf: fileURL) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
        
        self.people = []
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggleIsContacted(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            do {
                try encoded.write(to: fileURL)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

//
//  ProspectModel.swift
//  Hot Prospects
//
//  Created by Christopher Sherman on 2023-08-28.
//

import SwiftUI

class Prospect: Identifiable, Codable, Comparable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    static func <(lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        return lhs.id == rhs.id
    }
}

enum ProspectsSortOrder {
    case NameAsc, NameDesc
    
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect] = []
    @Published var sortOrder = ProspectsSortOrder.NameAsc {
        didSet {
            sortPeople()
        }
    }
    
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
        sortPeople()
        save()
    }
    
    private func sortPeople() {
        switch sortOrder {
        case .NameAsc:
            people.sort()
        case .NameDesc:
            people.sort(by: { (lhs: Prospect, rhs: Prospect) -> Bool in
                return rhs.name < lhs.name
            })
        }
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

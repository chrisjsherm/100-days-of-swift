//
//  DataController.swift
//  Bookworm
//
//  Created by Christopher Sherman on 2023-07-12.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data filaed to load: \(error.localizedDescription)")
            }
        }
    }
}

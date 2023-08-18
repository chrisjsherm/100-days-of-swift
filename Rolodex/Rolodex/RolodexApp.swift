//
//  RolodexApp.swift
//  Rolodex
//
//  Created by Christopher Sherman on 2023-08-17.
//

import SwiftUI

@main
struct RolodexApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

//
//  FriendInfoApp.swift
//  FriendInfo
//
//  Created by Christopher Sherman on 2023-07-21.
//

import SwiftUI

@main
struct FriendInfoApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

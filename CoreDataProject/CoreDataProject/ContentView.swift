//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Christopher Sherman on 2023-07-18.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

        @FetchRequest(sortDescriptors: []) var animals: FetchedResults<Animal>

        var body: some View {
            VStack {
                List(animals, id: \.self) { animal in
                    Text(animal.name ?? "Unknown")
                }

                Button("Add") {
                    let animal = Animal(context: moc)
                    animal.name = "Turtle"
                }

                Button("Save") {
                    do {
                        try moc.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

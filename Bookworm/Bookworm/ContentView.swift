//
//  ContentView.swift
//  Bookworm
//
//  Created by Christopher Sherman on 2023-07-12.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            List(students) { student in
                Text(student.name ?? "Billy Willy")
            }
            
            Button("Add") {
                let firstNames = ["Jenny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                
                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!
                
                let student = Student(context: context)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                try? context.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static private var dataController = DataController()
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}

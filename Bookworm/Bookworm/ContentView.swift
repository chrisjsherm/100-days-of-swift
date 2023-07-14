//
//  ContentView.swift
//  Bookworm
//
//  Created by Christopher Sherman on 2023-07-12.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading)
                            {
                                Text(book.title ?? "Unknown title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add Book", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // Find book in our fetch request.
            let book = books[offset]
            
            // Delete from the DB context.
            context.delete(book)
        }
        
        // Persist changes.
        try? context.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static private var dataController = DataController()
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}

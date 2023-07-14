//
//  DetailView.swift
//  Bookworm
//
//  Created by Christopher Sherman on 2023-07-13.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book: Book
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)

            Text((book.review ?? "")?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "No review" : book.review!)
                .padding()

            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    func deleteBook() {
        // Mark book as deleted.
        context.delete(book)
        
        // Persist changes.
        try? context.save()
        
        dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: context)
        book.title = "Lemonysnickets"
        book.author = "Kermit the Frog"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book!"
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}

//
//  AddBookView.swift
//  Bookworm
//
//  Created by Christopher Sherman on 2023-07-13.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Thriller"
    @State private var review = ""
    @State private var reviewPlaceholder = "What did you think?"
    @State private var isSubmitClicked = false
    
    private let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    private var isFormDisabled: Bool {
        title.count == 0 || author.count == 0
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    ZStack {
                        if review.isEmpty {
                            TextEditor(text: $reviewPlaceholder)
                                .font(.body)
                                .foregroundColor(.gray)
                                .disabled(true)
                        }
                        TextEditor(text: $review)
                            .font(.body)
                            .opacity(review.isEmpty ? 0.25 : 1)
                    }

                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }

                Section {
                    Button("Save") {
                        if isFormDisabled {
                            isSubmitClicked = true
                            return
                        }
                        
                        let newBook = Book(context: context)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        
                        try? context.save()
                        dismiss()
                    }
                    .disabled(isSubmitClicked && isFormDisabled)
                    
                    if isSubmitClicked && isFormDisabled {
                        if title.count == 0 {
                            Text("Title is a required field")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        if author.count == 0 {
                            Text("Author is a required field")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                        
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}

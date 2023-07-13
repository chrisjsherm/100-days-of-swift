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
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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

//
//  DetailView.swift
//  Rolodex
//
//  Created by Christopher Sherman on 2023-08-21.
//

import SwiftUI

struct DetailView: View {
    let contact: Person
    
    var body: some View {
        VStack {
            Image(uiImage: contact.contactPhoto)
                .resizable()
                .scaledToFit()
        }
        .frame(
            maxWidth: .infinity, // Full Screen Width
            maxHeight: .infinity, // Full Screen Height
            alignment: .top
        ) // Align To top
        .navigationTitle(contact.name ?? "Unknown contact")
    }
}


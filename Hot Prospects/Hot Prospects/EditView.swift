//
//  EditView.swift
//  Hot Prospects
//
//  Created by Christopher Sherman on 2023-08-23.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $user.name)
            }
            .navigationTitle("Edit")
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}

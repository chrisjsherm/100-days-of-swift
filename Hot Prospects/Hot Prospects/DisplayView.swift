//
//  DisplayView.swift
//  Hot Prospects
//
//  Created by Christopher Sherman on 2023-08-23.
//

import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        NavigationView {
            Text(user.name)
                .navigationTitle("Display")
        }
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}

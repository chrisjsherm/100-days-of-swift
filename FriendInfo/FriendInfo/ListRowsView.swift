//
//  ListRowsView.swift
//  FriendInfo
//
//  Created by Christopher Sherman on 2023-07-21.
//

import SwiftUI

struct ListRowsView: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .font(.headline)
            
            Spacer()
            
            Text(value)
                .font(.headline)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ListRowsView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowsView(title: "Title", value: "The Adventures of Huckleberry Finn")
    }
}

//
//  FriendDetailView.swift
//  FriendInfo
//
//  Created by Christopher Sherman on 2023-07-21.
//

import SwiftUI

struct FriendDetailView: View {
    let friend: Friend
    
    var body: some View {
        List {
            ListRowsView(title: "Age", value: "\(friend.age)")
            ListRowsView(title: "Address", value: friend.address)
            ListRowsView(title: "Company", value: friend.company)
            ListRowsView(title: "Email Address", value: friend.email)
            ListRowsView(title: "About", value: friend.about)
        }
        .navigationTitle(friend.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FriendDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: "2015-11-10T01:47:18-00:00") ?? Date.now
        
        let friend = Friend(id: UUID(), isActive: true, name: "Mark Twain", age: 55, company: "American Classics", email: "mark.twain@us.gov", address: "55 Main St, Richmond, VA", about: "Funny author", registered: date, tags: ["funny", "classic"], friends: [])
        
        FriendDetailView(friend: friend)
    }
}

//
//  FriendDetailView.swift
//  FriendInfo
//
//  Created by Christopher Sherman on 2023-07-21.
//

import SwiftUI

struct FriendDetailView: View {
    let friend: CachedFriend
    
    var body: some View {
        List {
            ListRowsView(title: "Age", value: "\(friend.age)")
            ListRowsView(title: "Address", value: friend.wrappedAddress)
            ListRowsView(title: "Company", value: friend.wrappedCompany)
            ListRowsView(title: "Email Address", value: friend.wrappedEmail)
            ListRowsView(title: "About", value: friend.wrappedAbout)
        }
        .navigationTitle(friend.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}


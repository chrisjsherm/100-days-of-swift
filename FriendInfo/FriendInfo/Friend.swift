//
//  Friend.swift
//  FriendInfo
//
//  Created by Christopher Sherman on 2023-07-21.
//

import Foundation

struct Friend: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int16
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [FriendReference]
}

struct FriendReference: Codable, Identifiable {
    var id: UUID
    var name: String
}


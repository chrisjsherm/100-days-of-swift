//
//  User.swift
//  HWS 100 Days of SwiftUI
//
//  Created by Christopher Sherman on 2023-05-08.
//

import Foundation

struct User {
    let username: String
    var lastLogin: Date = Date()
    var lastLoginPrettyPrint: String {
        return lastLogin.formatted(date: .abbreviated, time: .standard)        
    }
    
    mutating func login() {
        lastLogin = Date()
    }
}

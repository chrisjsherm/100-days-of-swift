//
//  CachedFriend+CoreDataProperties.swift
//  FriendInfo
//
//  Created by Christopher Sherman on 2023-07-24.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var company: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?

}

// MARK: Generated accessors for friends
extension CachedFriend {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedFriend : Identifiable {
    public var wrappedName: String {
        name ?? "NAME"
    }
    
    public var wrappedEmail: String {
        email ?? "EMAIL"
    }
    
    public var wrappedAddress: String {
        address ?? "ADDRESS"
    }
    
    public var wrappedAbout: String {
        about ?? "ABOUT"
    }
    
    public var wrappedCompany: String {
        company ?? "COMPANY"
    }
    
    public var friendsArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var tagsArray: [String] {
        get {
            return tags?.split(separator: ",") as? [String] ?? []
        }
        
        set {
            tags = newValue.joined(separator: ",")
        }
    }
}

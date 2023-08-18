//
//  Contact+CoreDataProperties.swift
//
//
//  Created by Christopher Sherman on 2023-08-18.
//

import Foundation
import CoreData
import UIKit

@objc(Contact)
class Contact: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var photo: UIImage?

}

extension Contact : Identifiable {
    public var wrappedPhoto: UIImage {
        photo ?? UIImage(systemName: "heart.fill")!
    }
}

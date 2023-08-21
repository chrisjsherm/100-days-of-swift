//
//  Person+CoreDataProperties.swift
//  Rolodex
//
//  Created by Christopher Sherman on 2023-08-21.
//
//

import Foundation
import CoreData
import UIKit
import SwiftUI


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var photoId: UUID?

}

extension Person : Identifiable {
    public var contactPhoto: UIImage {
        let fileName = "\(photoId?.uuidString ?? "photoID").jpg"
        print("Attempting to load \(fileName)")
        
        let imageURL = FileManager.documentsDirectory.appendingPathComponent(fileName)
        
        guard let image = UIImage(contentsOfFile: imageURL.path) else {
            return UIImage(systemName: "heart.fill")!
        }
        return image
    }
}

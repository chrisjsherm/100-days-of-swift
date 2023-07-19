//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Christopher Sherman on 2023-07-19.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

}

extension Candy : Identifiable {
    public var wrappedName: String {
        name ?? "Unknown candy"
    }
}

//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Christopher Sherman on 2023-07-18.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

    public var wrappedTitle: String {
        title ?? "Unknown title"
    }
    
    public var wrappedDirector: String {
        director ?? "Unknown director"
    }
}

extension Movie : Identifiable {

}

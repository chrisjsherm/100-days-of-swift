//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Christopher Sherman on 2023-07-19.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        if fetchRequest.isEmpty {
            Text("No matching result")
        } else {
            List(fetchRequest, id: \.self) { item in
                self.content(item)
            }
        }
    }

    init(
        filterKey: String,
        filterValue: String,
        filterOperator: FilterOperator,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        _fetchRequest = FetchRequest<T>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "%K \(filterOperator.rawValue) %@", filterKey, filterValue)
        )
        self.content = content
    }
}

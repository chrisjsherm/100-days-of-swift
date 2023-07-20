//
//  FilterOperator.swift
//  CoreDataProject
//
//  Created by Christopher Sherman on 2023-07-20.
//

import Foundation

enum FilterOperator: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
    case endsWith = "ENDSWITH"
    case equals = "=="
    case greaterThan = ">"
    case greaterThanOrEqualTo = ">="
    case lessThan = "<"
    case lessThanOrEqualTo = "<="
    case like = "LIKE"
    case notEquals = "!="
}

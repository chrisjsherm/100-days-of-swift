//
//  EmployeeError.swift
//  HWS 100 Days of SwiftUI
//
//  Created by Christopher Sherman on 2023-05-04.
//

import Foundation

public enum EmployeeError: Error {
    case emptyNames, emptyFirstName, emptyLastName
}

extension EmployeeError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyFirstName:
            return NSLocalizedString("Employee:Empty first name", comment: "Attempted to create an employee without supplying first name")
            
        case .emptyLastName:
            return NSLocalizedString("Employee:Empty last name", comment: "Attemped to create an employee without supplying last name")
            
        case .emptyNames:
            return NSLocalizedString("Employee:Empty first and last name", comment: "Attempted to create an employee without supplying first and last name")
        }
    }
}

//
//  LocalizedError.swift
//  Multiply
//
//  Created by Christopher Sherman on 2023-06-16.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

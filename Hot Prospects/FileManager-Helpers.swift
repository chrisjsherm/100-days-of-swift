//
//  FileManager-Helpers.swift
//  Hot Prospects
//
//  Created by Christopher Sherman on 2023-08-31.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

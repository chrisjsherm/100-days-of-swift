//
//  FileManager-Helpers.swift
//  Bucket List
//
//  Created by Christopher Sherman on 2023-08-04.
//

import Foundation

extension FileManager {
    
    func writeToStorage(fileName: String, value: String) throws {
        let url = FileManager.documentsDirectory.appendingPathComponent(fileName)
        try value.write(to: url, atomically: true, encoding: .utf8)
    }
    
    func readFromStorage(fileName: String) throws -> String {
        let url = FileManager.documentsDirectory.appendingPathComponent(fileName)
        return try String(contentsOf: url)
    }
}

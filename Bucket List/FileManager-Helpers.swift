//
//  FileManager-Helpers.swift
//  Bucket List
//
//  Created by Christopher Sherman on 2023-08-04.
//

import Foundation

extension FileManager {
    
    func writeToStorage(fileName: String, value: String) throws {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        try value.write(to: url, atomically: true, encoding: .utf8)
    }
    
    func readFromStorage(fileName: String) throws -> String {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        return try String(contentsOf: url)
    }
    
    private func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

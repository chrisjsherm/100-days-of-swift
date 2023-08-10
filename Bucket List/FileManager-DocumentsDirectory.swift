//
//  FileManager-DocumentsDirectory.swift
//  Bucket List
//
//  Created by Christopher Sherman on 2023-08-10.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

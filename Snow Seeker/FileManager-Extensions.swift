//
//  FileManager-Extensions.swift
//  Snow Seeker
//
//  Created by Christopher Sherman on 2023-09-21.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

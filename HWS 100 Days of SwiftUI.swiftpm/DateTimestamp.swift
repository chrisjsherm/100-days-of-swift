//
//  DateTimestamp.swift
//  HWS 100 Days of SwiftUI
//
//  Created by Christopher Sherman on 2023-05-05.
//

import Foundation

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

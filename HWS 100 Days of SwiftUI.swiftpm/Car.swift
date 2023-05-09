//
//  Car.swift
//  HWS 100 Days of SwiftUI
//
//  Created by Christopher Sherman on 2023-05-09.
//

import Foundation

struct Car {
    let model: String
    let numberOfSeats: Int
    let gearCount: Int
    private(set) var currentGear: Int
    
    mutating func shiftUp() throws -> Int {
        guard currentGear != gearCount else {
            throw GearShiftError.runtimeError("Already in top gear")
        }
        
        currentGear += 1
        return currentGear
    }
    
    mutating func shiftDown() throws -> Int {
        guard currentGear != 1 else {
            throw GearShiftError.runtimeError("Already in first gear")
        }
        
        currentGear -= 1
        return currentGear
    }
}

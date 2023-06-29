//
//  FlowerShape.swift
//  Drawing
//
//  Created by Christopher Sherman on 2023-06-29.
//

import Foundation
import SwiftUI

struct Flower: Shape {
    // How much to move this petal away from the center.
    var petalOffset = -20.0
    
    // How wide to make each petal.
    var petalWidth = 100.0
    
    func path(in rect: CGRect) -> Path {
        // The path that will hold all petals.
        var path = Path()
        
        // Count from 0 up to pi * 2, moving up pi / 8 each time.
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            // Rotate the petal by the current value of our loop.
            let rotation = CGAffineTransform(rotationAngle: number)
            
            // Move the pteal to be at the center of our view.
            let position = rotation.concatenating(CGAffineTransform(
                translationX: rect.width / 2, y: rect.height / 2))
            
            // Create a path for this petal using our properties plus a fixed Y
            // and height.
            let originalPetal = Path(ellipseIn: CGRect(
                x: petalOffset, y: 0, width: petalWidth,
                height: rect.width / 2))
            
            // Apply our rotation/position transformation to the petal.
            let rotatedPetal = originalPetal.applying(position)
            
            // Add to our main path.
            path.addPath(rotatedPetal)
        }
        
        // Send back the main path.
        return path
    }
}

//
//  Helper-withOptionalAnimationWrapper.swift
//  Flashzilla
//
//  Created by Christopher Sherman on 2023-09-04.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

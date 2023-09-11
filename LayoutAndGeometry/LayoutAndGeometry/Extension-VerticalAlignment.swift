//
//  VerticalAlignment.swift
//  LayoutAndGeometry
//
//  Created by Christopher Sherman on 2023-09-11.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

//
//  UIImage-Helpers.swift
//  Hot Prospects
//
//  Created by Christopher Sherman on 2023-08-31.
//

import SwiftUI

extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: round(width), height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext();
        context?.interpolationQuality = .none
        // Set the quality level to use when rescaling
        draw(in: CGRect(origin: .zero, size: canvasSize))
        let r = UIGraphicsGetImageFromCurrentImageContext()
        return r
    }
}
